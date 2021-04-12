function measurement_data = verify_parameters( measurement_data )
    for i = 1:length(measurement_data)
        for j = 1:length(measurement_data(i).experiments)
            q0 = measurement_data(i).experiments(j).peaks.value(1);
            t0 = measurement_data(i).experiments(j).time(measurement_data(i).experiments(j).peaks.index(1));
            tN = measurement_data(i).experiments(j).time(measurement_data(i).experiments(j).peaks.index(end));
            
            p = [measurement_data(i).experiments(j).parameters.zeta, measurement_data(i).experiments(j).parameters.omega_n];
            [tout, yout] = ode23t(@(t,x) damped_harmonic_oscilliator(t, x, p), [t0, tN], [q0, 0]);
            
            measurement_data(i).experiments(j).verification.value = yout(:,1);
            measurement_data(i).experiments(j).verification.time = tout;
        end
    end
end

