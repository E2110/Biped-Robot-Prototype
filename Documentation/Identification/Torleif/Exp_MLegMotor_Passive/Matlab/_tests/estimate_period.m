function measurement_data = estimate_period( measurement_data )
    for i = 1:length(measurement_data)
        for j = 1:length(measurement_data(i).experiments)
            range = measurement_data(i).experiments(j).peaks.index(1):measurement_data(i).experiments(j).peaks.index(end);
            
            x_data = measurement_data(i).experiments(j).time(range);
            y_data = measurement_data(i).experiments(j).encoder_angle(range);
            
            prev_sign = 0;
            zero_i = [];
            for k = 1:length(y_data)
                current_sign = sign(y_data(k));
                if current_sign ~= prev_sign && prev_sign ~= 0
                    x1 = x_data(k-1);
                    x2 = x_data(k);
                    y1 = y_data(k-1);
                    y2 = y_data(k);
                    crossing = (x2*y1-x1*y2)/(y1-y2);
                    zero_i = [zero_i; crossing];
                end
                prev_sign = current_sign;
            end
            
            T = zeros(length(zero_i)-2, 1);
            
            for k = 1:length(T)
                T(k) = zero_i(k+2) - zero_i(k); 
            end
            
            measurement_data(i).experiments(j).zero = zero_i;
            measurement_data(i).experiments(j).T = T;
            
        end 
    end
end

