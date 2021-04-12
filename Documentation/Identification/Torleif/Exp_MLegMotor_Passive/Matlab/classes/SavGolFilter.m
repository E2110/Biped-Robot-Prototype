classdef SavGolFilter < handle
    
    properties
        buffer
        buffer_length_left
        buffer_length_right
        buffer_full
        buffer_data_inputs
        sample_time
        order
        coefficients
    end
    
    methods
        function obj = SavGolFilter(buffer_length_left, buffer_length_right, order, sample_time)
            obj.buffer_length_left = buffer_length_left;
            obj.buffer_length_right = buffer_length_right;
            obj.order = order;
            obj.sample_time = sample_time;
            
            % Calculate filter coefficients
            z_i = -buffer_length_left:buffer_length_right;
            J = zeros(length(z_i), order+1);

            for i=1:length(z_i)
                J(i,:) = z_i(i).^(0:order);
            end

            C = (J'*J)\(J');
            obj.coefficients = [C(1,:); C(2,:)/sample_time];
            
            % Create buffer
            obj.buffer = zeros(length(z_i), 1);
            obj.buffer_full = false;
            obj.buffer_data_inputs = 0;
        end
        
        function [Y, dY, buffer_full] = filter(obj, y)
            obj.buffer(1:end-1) = obj.buffer(2:end);
            obj.buffer(end) = y;
            
            obj.buffer_data_inputs = obj.buffer_data_inputs + 1; 
            if obj.buffer_data_inputs >= length(obj.buffer)
                obj.buffer_full = true;
            end

            Y = dot(obj.coefficients(1,:), obj.buffer);
            dY = dot(obj.coefficients(2,:), obj.buffer);
            buffer_full = obj.buffer_full;
        end
        
        function reset_buffer(obj)
            obj.buffer = zeros(size(obj.buffer));
            obj.buffer_full = false;
            obj.buffer_data_inputs = 0;
        end
        
        function add_to_buffer(obj, data)
            obj.buffer_data_inputs = obj.buffer_data_inputs + length(data);
            for i = 1:length(data)
                obj.buffer(1:end-1) = obj.buffer(2:end);
                obj.buffer(end) = data(i);
            end
        end
    end

end

