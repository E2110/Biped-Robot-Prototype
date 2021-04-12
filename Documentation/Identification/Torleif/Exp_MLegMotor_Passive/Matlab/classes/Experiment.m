classdef Experiment < handle
    properties
        name
        weight_pos
        sampling_rate
        
        encoder_time
        encoder_angle
        
        filtered_time
        filtered_angle
        filtered_velocity
        filtered_zero_crossings
        
        encoder_data_shift
        
        linear_time
        linear_angle
        linear_zero_crossings
        
        estimated_parameters
        
        estimated_time
        estimated_angle
        estimated_velocity
    end
    
    methods
        %% Constructor
        function obj = Experiment(name, weight_pos, encoder_time, encoder_angle)
            if nargin == 0
                obj.name = '';
            else
                obj.name = name;
                obj.weight_pos = weight_pos;
                obj.encoder_time = encoder_time;
                obj.encoder_angle = encoder_angle;  
                
                obj.sampling_rate = encoder_time(2) - encoder_time(1);
            end
        end
        
        %% Compensate deadzone and SavGol filter to smooth data
        function filter_data(obj, savgol_filter)
            % Interpolate missing data           
            interpolated_time = obj.encoder_time(1):obj.sampling_rate:obj.encoder_time(end);
            interpolated_angle = interp1(obj.encoder_time, obj.encoder_angle, interpolated_time);

            % Reset SavGol filter
            buffer_length = savgol_filter.buffer_length_left + savgol_filter.buffer_length_right + 1;
            savgol_filter.reset_buffer();
            savgol_filter.add_to_buffer(interpolated_angle(1:buffer_length-1));

            obj.filtered_time = zeros(length(interpolated_angle) - buffer_length + 1, 1);
            obj.filtered_angle = zeros(size(obj.filtered_time));
            obj.filtered_velocity = zeros(size(obj.filtered_time));

%             switch_interval = 50;
%             compensate_duration = switch_interval + 1;
%             compensate_deadzone = 0;
%             clear ramp
            for i = 1:(length(interpolated_angle) - buffer_length) + 1
                obj.filtered_time(i) = interpolated_time(i + savgol_filter.buffer_length_left);
%               [obj.filtered_angle(k), obj.filtered_velocity(k)] = savgol_filter.filter(interpolated_angle(k + buffer_length - 1) + ramp(compensate_deadzone) * obj.imported_parameters.deadzone.MLeg_Deadzone);
                [obj.filtered_angle(i), obj.filtered_velocity(i)] = savgol_filter.filter(interpolated_angle(i + buffer_length - 1));

%                 if k > 1 && obj.filtered_velocity(k-1)*obj.filtered_velocity(k) < 0 && compensate_duration > switch_interval
%                     compensate_deadzone = 1;
%                     compensate_duration = 0;
%                 else
%                     compensate_deadzone = 0;
%                     compensate_duration = compensate_duration + 1;
%                 end
            end
        end
     
        %% Find encoder bias from startup
         function estimate_encoder_data_shift(obj)
            % Sum of squares of differences between intervals between zero crossings
            objective_function = @(encoder_data_shift) sum(diff(diff(estimate_zero_crossings([obj.filtered_time, obj.filtered_angle], encoder_data_shift))).^2);

            options = optimset('TolFun', 1e-5, 'TolX', 1e-5);
            obj.encoder_data_shift = fminsearch(objective_function, 0, options);
            obj.filtered_angle = obj.filtered_angle + obj.encoder_data_shift;
         end
         
        %% Extract linear data segment
        function extract_linear_segment(obj, min_peak_height)
            [pks, i_pks] = findpeaks((obj.filtered_angle), 'MinPeakHeight', min_peak_height);
            i_0 = i_pks(find(pks < 14*pi/180, 1, 'first'));
            
            obj.linear_time = obj.filtered_time(i_0:end);
            obj.linear_angle = obj.filtered_angle(i_0:end);
        end
        
        %% Estimate base coefficients
        function estimate_base_coefficients(obj, min_peak_height, min_peak_distance)
            [peaks, t_p] = findpeaks(obj.linear_angle, obj.linear_time, 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);
            [valleys, t_v] = findpeaks(-obj.linear_angle, obj.linear_time, 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);
            valleys = -valleys;

            Y = zeros(length(valleys)+length(peaks),1); 

            if t_p(1) < t_v(1)
                Y(1:2:2*length(peaks)-1) = peaks;
                Y(2:2:2*length(valleys)) = valleys;
            else
                Y(1:2:2*length(valleys)-1) = valleys;
                Y(2:2:2*length(peaks)) = peaks;
            end

            beta = zeros(length(Y)-3,1);
            
            for i = 3:length(Y)-1
                e = (Y(i+1) - Y(i-1))/(Y(i) - Y(i-2));
                beta(i-2) = -log(-e)/pi;
            end

            beta_avg = sum(beta)/length(beta); 
            obj.estimated_parameters.beta = beta_avg;
            obj.estimated_parameters.zeta = sqrt(beta_avg^2/(1+beta_avg^2));

            alpha = zeros(length(Y)-2,1);
            for i = 2:length(Y)-1
                alpha(i-1) = (Y(i+1)-Y(i) + exp(-beta_avg*pi)*(Y(i)-Y(i-1)))/(2*(-1)^(-i)*(exp(-beta_avg*pi)+1));
            end

            alpha_avg = sum(alpha)/length(alpha);
            obj.estimated_parameters.alpha = alpha_avg;
        end
        
        %% Find natural frequency and friction coefficients
        function find_parameters(obj)
            obj.linear_zero_crossings = estimate_zero_crossings([obj.linear_time, obj.linear_angle]);
            half_T = diff(obj.linear_zero_crossings);
            if mod(length(half_T),2) == 1
                half_T = half_T(1:end-1);
            end

            T = half_T(1:2:end)+half_T(2:2:end);
            
            median_T = median(T);
            for i = length(T):-1:1
                if T(i)<0.9*median_T || T(i) > 1.1*median_T
                    T(i) = [];
                end
            end

            T_avg = sum(T)/length(T);

            w_d_0 = 2*pi/T_avg;
            w_n_0 = w_d_0/sqrt(1-obj.estimated_parameters.zeta^2);
            
            obj.filtered_zero_crossings = estimate_zero_crossings([obj.filtered_time, obj.filtered_angle]);
            
            lb = 0.5*w_n_0;
            ub = 1.5*w_n_0;

            sim_init.tspan = obj.filtered_time;
            sim_init.x0 = [obj.filtered_angle(1), (obj.filtered_angle(2)-obj.filtered_angle(1))/(obj.filtered_time(2)-obj.filtered_time(1))];
            sim_init.param.f_v = 2*obj.estimated_parameters.zeta*w_n_0;
            sim_init.param.f_c = obj.estimated_parameters.alpha*w_n_0^2;
            sim_init.param.w_n = w_n_0;
            
            options = optimoptions(@fmincon, 'Display','iter-detailed', 'TolFun', 1e-10, 'TolX', 1e-10);
            w_n = fmincon(@(w_n) obj.objective_function(sim_init, w_n), w_n_0, [], [], [], [], lb, ub, [], options);
            obj.estimated_parameters.w_n = w_n;
            obj.estimated_parameters.w_d = w_n*sqrt(1-obj.estimated_parameters.zeta^2);
            obj.estimated_parameters.f_v = 2*obj.estimated_parameters.zeta*w_n;
            obj.estimated_parameters.f_c = obj.estimated_parameters.alpha*w_n^2;
        end
        
        %% Objective function for natural frequency search
        function value = objective_function(obj, sim_init, w_n)
            sim_init.param.w_n = w_n;
            [time, position, ~] = simulate_passive_pendulum(sim_init);

            search_zero_crossings = estimate_zero_crossings([time, position]);

            length_search_zeros = length(search_zero_crossings);
            length_filtered_zeros = length(obj.filtered_zero_crossings);

            if length_search_zeros == 0
                value = Inf;
            elseif length_search_zeros < length_filtered_zeros
                value = sum((obj.filtered_zero_crossings(1:length_search_zeros)-search_zero_crossings).^2);
            elseif length_search_zeros > length_filtered_zeros
                value = sum((obj.filtered_zero_crossings(1:length_filtered_zeros)-search_zero_crossings(1:length_filtered_zeros)).^2) + sum((obj.filtered_zero_crossings(end)-search_zero_crossings(length_filtered_zeros+1:end)).^2);
            else 
                value = sum((obj.filtered_zero_crossings - search_zero_crossings).^2);
            end
        end
        
        %% Verify estimated parameters
        function verify_estimated_parameters(obj, parameters)
            sim_init.tspan = obj.filtered_time;
            sim_init.x0 = [obj.filtered_angle(1), (obj.filtered_angle(2)-obj.filtered_angle(1))/(obj.filtered_time(2)-obj.filtered_time(1))];
%             sim_init.param.f_v = obj.estimated_parameters.f_v;
%             sim_init.param.f_c = obj.estimated_parameters.f_c;
%             sim_init.param.w_n = obj.estimated_parameters.w_n;

            sim_init.param.f_v = parameters.f_v;
            sim_init.param.f_c = parameters.f_c;
            sim_init.param.w_n = parameters.w_n;

            [obj.estimated_time, obj.estimated_angle, obj.estimated_velocity] = simulate_passive_pendulum(sim_init);
        end
    end
    
end

