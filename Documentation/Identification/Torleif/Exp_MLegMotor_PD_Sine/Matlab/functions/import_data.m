function measurement_data = import_data(root_path)
    %% Import and organize raw data
    folders = dir(root_path); % Finds all files in folder
    experiments = folders([folders.isdir]); % Removes files that are not folders using logicals
    experiments(strncmp({experiments.name}, '.', 1)) = []; % Removes folders that start with '.'

    % {Variable name from data, fieldname assigned in script generated struct}
    data_parsing_map = containers.Map( ...
        {'Encoder angle (radians)', 'Angle', 'Velocity', 'Angle reference (radians)', 'Velocity reference (radians)', 'Kd', 'Kp', 'pos_weight_1', 'pos_weight_2', 'ref_amplitude', 'ref_frequency', 'filter_switch'}, ...
        {'encoder_angle', 'filter_angle', 'filter_velocity', 'ref_angle', 'ref_velocity' 'kd' 'kp' 'n_weight_1' 'n_weight_2', 'ref_amplitude', 'ref_frequency', 'filter_switch'} ...
    );

    % Find all experiment folders
    for i = 1:length(experiments)
        experiment = experiments(i);
        experiment_files = dir([root_path '/' experiment.name]);
        experiment_runs = experiment_files([experiment_files.isdir]);
        experiment_runs(strncmp({experiment_runs.name}, '.', 1)) = []; 

        exp_data(i).name = experiment.name; % Create index-able struct containing parsed experiment data

        % Find all runs contained within each experiment
        for j = 1:length(experiment_runs)
            run = experiment_runs(j);
            run_path = [root_path '/' experiment.name '/' run.name];
            exp_data(i).run(j).valid = ~strcmp(run.name(1), '_');

            data_files = dir(run_path);
            data_files = data_files(~[data_files.isdir]);

            % Find all .mat files contained in each run
            for k = 1:length(data_files)
                data_matfile = data_files(k);
                data_path = [run_path '/' data_matfile.name];
                file_container = load(data_path);
                file_name = fieldnames(file_container);
                data_struct = file_container.(file_name{1});

                % Fetch data from struct
                time = data_struct.X(1).Data;
                exp_data(i).run(j).data(k).time = time;

                for l = 1:length(data_struct.Y)
                    field = data_struct.Y(l);

                    if data_parsing_map.isKey(field.Name)
                        data = field.Data;

                        if ~isempty(data)
                            if length(data) < length(time) % Converts vectorized scalars back to scalars.
                                data = data(1);
                            end
                        end

                        exp_data(i).run(j).data(k).(data_parsing_map(field.Name)) = data;
                    end
                end          
            end
        end
        
        exp_data(i).kp = exp_data(i).run(j).data(1).kp;
        exp_data(i).kd = exp_data(i).run(j).data(1).kd;

        exp_data(i).n_weights = [exp_data(i).run(j).data(1).n_weight_1, exp_data(i).run(j).data(1).n_weight_2];
    end
    
    %% Remove invalid runs marked _Run_n and resulting empty experiments
    for i = length(exp_data):-1:1
        exp_data(i).run(~[exp_data(i).run.valid]) = [];

        if isempty(exp_data(i).run)
            exp_data(i) = [];
        end    
    end
    
    %% Sort experiments by weight placement
    index = 1;
    while ~isempty(exp_data)
        n_weights = exp_data(1).n_weights;
        measurement_data(index).n_weights = n_weights;
       
        temp_data = exp_data(1);
        temp_data(1) = [];
        
        for i = length(exp_data):-1:1
            if isequal(exp_data(i).n_weights, n_weights)
                temp_data(end+1) = exp_data(i);
                exp_data(i) = [];
            end
        end
        
        measurement_data(index).experiments = temp_data;
        index = index + 1;
    end
end

