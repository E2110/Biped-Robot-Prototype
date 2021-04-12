function plot_bode(measurement_data)
    for i = 1:length(measurement_data)
        for j = 1:length(measurement_data(i).experiments)
            exp = measurement_data(i).experiments(j);
            f0 = exp.w0_avg/(2*pi);
            
            figure(i*100 + j);

            subplot(2,1,1);
            hold on;
            
            for k = 1:length(exp.run)
                magnitude = exp.run(k).bode_magnitude;
                freq = exp.run(k).bode_frequency;

                plot(freq, magnitude, 'd-');
            end

            axis manual;

            y_lim = get(gca,'ylim');
            plot([f0 f0], y_lim ,':k');

            hold off;

            ylabel('Magnitude');
            xlabel('Hz');
            title({['Bode plot - ' strrep(exp.name, '_','\_')], ['Weight Pos 1: ' num2str(measurement_data(i).n_weights(1)) ', Weight Pos 2: ' num2str(measurement_data(i).n_weights(2))], ['K_p = ' num2str(exp.kp) ', K_d = ' num2str(exp.kd)]});

            subplot(2,1,2);
            hold on;
            for k = 1:length(exp.run)
                phase = exp.run(k).bode_phase;
                freq = exp.run(k).bode_frequency;

                plot(freq, phase, 'd-');
            end

            y_lim = get(gca,'ylim');
            x_lim = get(gca,'xlim');
            plot([f0 f0], y_lim ,':k');
            plot(x_lim, [-pi/2 -pi/2] ,':k');

            hold off;

            ylabel('Phase');
            xlabel('Hz');
        end
    end
end

