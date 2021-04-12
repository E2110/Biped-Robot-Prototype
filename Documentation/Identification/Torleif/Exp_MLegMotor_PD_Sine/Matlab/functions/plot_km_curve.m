function plot_km_curve(measurement_data)
    for i = 1:length(measurement_data)
        if ~isempty(measurement_data(i).km_curve)
            figure(1000 + i);
            hold on;
            plot(NaN,NaN,'xk'); % dummy for legend purposes
            plot(NaN,NaN,'or'); % dummy for legend purposes
            legend('\omega_0 average', '\omega_0 run estimates', 'Location','SE')

            for j = 1:length(measurement_data(i).experiments)
                exp = measurement_data(i).experiments(j);
                plot(ones(length([exp.run]),1)*exp.kp, [exp.run.w0_estimate].^2,'or');
                plot([exp.kp], [exp.w0_avg].^2, 'xk');
            end

            plot(measurement_data(i).kp_range, polyval(measurement_data(i).km_curve, measurement_data(i).kp_range)); 

            title({'Estimates of \omega_0^2 for different K_p', ['Weight Pos 1: ' num2str(measurement_data(i).n_weights(1)), ', Weight Pos 2: ' num2str(measurement_data(i).n_weights(2))]});
            ylabel('\omega_0^2');
            xlabel('Kp');
            hold off;
        end
    end
end

