classdef ExperimentHandler < handle
    properties
        sorted_experiments
        imported_parameters
        estimated_parameters
    end
    
    methods
        %% Constructor
        function obj = ExperimentHandler(recorded_data_path, parameter_path)
            obj.import_recorded_data(recorded_data_path);
            obj.import_parameters(parameter_path);
        end
        
        %% Import recorded data
        function import_recorded_data(obj, recorded_data_path)
            % Import and organize raw data
            fprintf('Importing experiment files\n');
            experiment_files = dir(fullfile(recorded_data_path,'*.mat')); % Finds all files in folder

            data_parsing_map = containers.Map( ...
                {'Model Root/Radian Position Middle Leg','Model Root/Weight_position_leg_1', 'Model Root/Weight_position_leg_2'}, ...
                {'encoder_angle', 'weight_1_pos' 'weight_2_pos',} ...
            );

            temp_experiments = repmat(Experiment(),length(experiment_files),1);
        
            % Find all experiment files
            for i = 1:length(experiment_files)
                experiment_name = experiment_files(i).name;
                file_container = load([recorded_data_path, experiment_name]);
                file_name = fieldnames(file_container);
                experiment_data = file_container.(file_name{1});

                % Fetch data from struct
                encoder_time = experiment_data.X(end).Data;

                for j = 1:length(experiment_data.Y)
                    field = experiment_data.Y(j);

                    if data_parsing_map.isKey(field.Path)
                        data = field.Data;

                        if ~isempty(data)
                            if length(data) < length(encoder_time) % Converts vectorized scalars back to scalars.
                                data = data(1);
                            end
                        end

                        temp_data.(data_parsing_map(field.Path)) = data;
                    end
                end     
                
                temp_experiments(i) = Experiment(experiment_name, [temp_data.weight_1_pos, temp_data.weight_2_pos], encoder_time, temp_data.encoder_angle);
            end

            % Sort experiments by weight placement
            index = 1;
            while ~isempty(temp_experiments)
                weight_pos = temp_experiments(1).weight_pos;
                obj.sorted_experiments(index).weight_pos = weight_pos;

                temp_data = Experiment.empty;

                for i = length(temp_experiments):-1:1
                    if isequal(temp_experiments(i).weight_pos, weight_pos)
                        temp_data(end+1) = temp_experiments(i);
                        temp_experiments(i) = [];
                    end
                end

                obj.sorted_experiments(index).experiments = temp_data;
                index = index + 1;
            end
        end
        
        %% Import parameters
        function import_parameters(obj, parameter_path)
            fprintf('Importing parameters\n');
            obj.imported_parameters = load([parameter_path 'parameters.mat']); 
        end
        
        %% Compensate for deadzone and SavGol filter data
        function filter_data(obj)
            % Initialize SavGol filter
            buffer_length_left = 50; 
            buffer_length_right = 50; % 0 -> causal filter
            filter_order = 2;
            savgol_filter = SavGolFilter(buffer_length_left, buffer_length_right, filter_order, obj.imported_parameters.sampling_rate);
            
            for i = 1:length(obj.sorted_experiments)             
                for j = 1:length(obj.sorted_experiments(i).experiments)
                    fprintf('Savitzky-Golay filtering data for weight position (%d,%d), experiment %d\n', obj.sorted_experiments(i).weight_pos(1), obj.sorted_experiments(i).weight_pos(2), j);
                    experiment = obj.sorted_experiments(i).experiments(j);
                    experiment.filter_data(savgol_filter);
                end
            end
        end
        
        %% Find encoder bias from startup
        function estimate_encoder_data_shift(obj)
            for i = 1:length(obj.sorted_experiments)
                for j = 1:length(obj.sorted_experiments(i).experiments)
                    experiment = obj.sorted_experiments(i).experiments(j);
                    
                    fprintf('Estimating encoder data shift for weight number (%d,%d), experiment %d: ', obj.sorted_experiments(i).weight_pos(1), obj.sorted_experiments(i).weight_pos(2), j);
                    experiment.estimate_encoder_data_shift();
                    fprintf('%d \n', experiment.encoder_data_shift);
                end 
            end
        end
        
        
        %% Find friction and frequency parameters
        function find_parameters(obj)
            for i = 1:length(obj.sorted_experiments)
                parameter_sum = struct('beta',0,'zeta',0,'alpha',0,'w_n',0,'w_d',0,'f_v',0,'f_c',0);
                for j = 1:length(obj.sorted_experiments(i).experiments)
                    fprintf('Finding parameters for weight number (%d,%d), experiment %d:\n', obj.sorted_experiments(i).weight_pos(1), obj.sorted_experiments(i).weight_pos(2), j)
                    
                    experiment = obj.sorted_experiments(i).experiments(j);
                    
                    experiment.extract_linear_segment(pi/180);
                    experiment.estimate_base_coefficients(2*pi/180, 0.5);
                    experiment.find_parameters();
                    
                    fprintf('Estimated parameters:\n');
                    fprintf(' f_v: %f\n', experiment.estimated_parameters.f_v);
                    fprintf(' f_c: %f\n', experiment.estimated_parameters.f_c);
                    fprintf(' w_n: %f\n', experiment.estimated_parameters.w_n);
                    
                    parameter_sum.beta = parameter_sum.beta + experiment.estimated_parameters.beta;
                    parameter_sum.zeta = parameter_sum.zeta + experiment.estimated_parameters.zeta;
                    parameter_sum.alpha = parameter_sum.alpha + experiment.estimated_parameters.alpha;
                    parameter_sum.w_n = parameter_sum.w_n + experiment.estimated_parameters.w_n;
                    parameter_sum.w_d = parameter_sum.w_d + experiment.estimated_parameters.w_d;
                    parameter_sum.f_v = parameter_sum.f_v + experiment.estimated_parameters.f_v;
                    parameter_sum.f_c = parameter_sum.f_c + experiment.estimated_parameters.f_c;
                end 
                
                
                mean_parameters.beta = parameter_sum.beta / j;
                mean_parameters.zeta = parameter_sum.zeta / j;
                mean_parameters.alpha = parameter_sum.alpha / j;
                mean_parameters.w_n = parameter_sum.w_n / j;
                mean_parameters.w_d = parameter_sum.w_d / j;
                mean_parameters.f_v = parameter_sum.f_v / j;
                mean_parameters.f_c = parameter_sum.f_c / j;
                obj.sorted_experiments(i).estimated_parameters = mean_parameters;
                
                fprintf('Mean of estimated parameters for weight number (%d,%d):\n', obj.sorted_experiments(i).weight_pos(1), obj.sorted_experiments(i).weight_pos(2));
                fprintf(' f_v: %f\n', mean_parameters.f_v);
                fprintf(' f_c: %f\n', mean_parameters.f_c);
                fprintf(' w_n: %f\n', mean_parameters.w_n);
            end
            
        end
        
        %% Verify estimated parameters
        function verify_estimated_parameters(obj)
            for i = 1:length(obj.sorted_experiments)
                for j = 1:length(obj.sorted_experiments(i).experiments) 
                    fprintf('Verifying estimated parameters for weight number (%d,%d), experiment %d:\n', obj.sorted_experiments(i).weight_pos(1), obj.sorted_experiments(i).weight_pos(2), j)
                    experiment = obj.sorted_experiments(i).experiments(j);
                    experiment.verify_estimated_parameters(obj.sorted_experiments(i).estimated_parameters);
                end
            end
        end
        
        %% Estimate lumped parameters from natural frequency
        function estimate_lumped_parameters(obj)
                A = [];
                b = [];

                I_w = obj.imported_parameters.etalon_weights.I_w;
                tau_w = obj.imported_parameters.etalon_weights.tau_w;
                
                for i = 1:length(obj.sorted_experiments)
                    weight_pos = obj.sorted_experiments(i).weight_pos;
                    w_n = obj.sorted_experiments(i).estimated_parameters.w_n;

                    A(end+1,:) = [1 -w_n^2];
                    b(end+1,1) = w_n^2*sum(I_w(weight_pos+1))-sum(tau_w(weight_pos+1));
                end

                x = A\b;

                obj.estimated_parameters.mgl = x(1);
                obj.estimated_parameters.I = x(2); 
        end

        %% Template
        function template(obj)
            for i = 1:length(obj.sorted_experiments)
                for j = 1:length(obj.sorted_experiments(i).experiments)
                    experiment = obj.sorted_experiments(i).experiments(j);
                end 
            end
        end
    end
end

