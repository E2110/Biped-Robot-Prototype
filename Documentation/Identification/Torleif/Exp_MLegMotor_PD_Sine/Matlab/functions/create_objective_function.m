function obj = create_objective_function(measurement_data)
    J_weights = [];
    tau_weights = [];
    kp = [];
    a = [];
    b = [];
    w0_avg = [];

    for i = 1:length(measurement_data)
        if ~isempty(measurement_data(i).kp_curve)
%             for j = 1:length(measurement_data(i).experiments)
%                 J_weights(end+1,1) = sum(measurement_data(i).J_weights);
%                 tau_weights(end+1,1) = sum(measurement_data(i).tau_weights);
%                 a(end+1,1) = measurement_data(i).kp_curve(1);
%                 b(end+1,1) = measurement_data(i).kp_curve(2);
%                 kp(end+1,1) = measurement_data(i).experiments(j).kp;
%                 w0_avg(end+1,1) = measurement_data(i).experiments(j).w0_avg;
%             end

            J_weights(end+1,1) = sum(measurement_data(i).J_weights);
            tau_weights(end+1,1) = sum(measurement_data(i).tau_weights);
            a(end+1,1) = measurement_data(i).kp_curve(1);
            b(end+1,1) = measurement_data(i).kp_curve(2);
%             kp(end+1,1) = measurement_data(i).experiments(j).kp;
%             w0_avg(end+1,1) = measurement_data(i).experiments(j).w0_avg;
        end
    end
    
%     obj = @(x) (x(1) + tau_weights )./(x(2) + J_weights) + a.*kp - w0_avg.^2;
    obj = @(x) (x(1) + tau_weights )./(x(2) + J_weights) - b;
end

