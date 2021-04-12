function measurement_data = estimate_parameters(measurement_data)
    for i = 1:length(measurement_data)
        for j = 1:length(measurement_data(i).experiments)
            T = measurement_data(i).experiments(j).T;
            
            omega_d_i = 2*pi./T;
            omega_d = sum(omega_d_i)/length(omega_d_i);
            
            peaks = measurement_data(i).experiments(j).peaks.value;
            n_peaks = length(measurement_data(i).experiments(j).zero)/2 + 1;
            
            zeta = (1/(n_peaks-1))*log(peaks(1)/peaks(end))./sqrt(4*pi^2 + log((1/(n_peaks-1))*(peaks(1)/peaks(end))).^2);
            
            omega_n_i = omega_d_i./sqrt(1-zeta^2); 
            omega_n = omega_d./sqrt(1-zeta^2); 
            
            parameters.omega_d_i = omega_d_i;
            parameters.omega_d = omega_d;
            parameters.zeta = zeta;
            parameters.omega_n_i = omega_n_i;
            parameters.omega_n = omega_n;
        
            measurement_data(i).experiments(j).parameters = parameters;
        end
        
        param = [measurement_data(i).experiments.parameters];
        
        temp.omega_d_avg = sum([param.omega_d])/length([param.omega_d]); 
        temp.zeta_avg = sum([param.zeta])/length([param.zeta]);
        temp.omega_n_avg = sum([param.omega_n])/length([param.omega_n]);
        
        measurement_data(i).parameters = temp; 
    end
end

