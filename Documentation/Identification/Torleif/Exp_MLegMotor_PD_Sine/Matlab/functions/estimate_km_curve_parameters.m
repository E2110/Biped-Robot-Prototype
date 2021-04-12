function measurement_data = estimate_km_curve_parameters(measurement_data)
    for i = 1:length(measurement_data)
        if length(measurement_data(i).experiments) > 1
            
            exps = measurement_data(i).experiments;
            x_data = [exps.kp];
            y_data = [exps.w0_avg].^2;

            data = sortrows([x_data' y_data']);
            x_data = data(:,1);
            y_data = data(:,2);
            P = polyfit(x_data, y_data, 1);

%             x_data = linspace(x_data(1),x_data(end));
            
            measurement_data(i).km_curve = P;
            measurement_data(i).kp_range = x_data;
        end
    end
end



