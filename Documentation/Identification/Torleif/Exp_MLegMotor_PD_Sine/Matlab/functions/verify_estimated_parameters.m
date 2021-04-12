function verification = verify_estimated_parameters(measurement_data, parameters)
    index = 1;
    for i = 1:length(measurement_data)
        if length(measurement_data(i).experiments) >= 1
            exp = measurement_data(i).experiments(1);
            
            tau_weights = sum(measurement_data(i).tau_weights);
            J_weights = sum(measurement_data(i).J_weights);
            kp = exp.kp;
            
            verification(index).kp = kp;
            verification(index).n_weights = measurement_data(i).n_weights;
            verification(index).w0_avg = exp.w0_avg;
            
            mgl = parameters.mgl;
            J = parameters.J;
            Km = parameters.Km;
            
            verification(index).w0_est = sqrt((mgl+tau_weights + Km*kp)/(J+J_weights));
            
            verification(index).w0_error = verification(index).w0_avg - verification(index).w0_est;
            verification(index).w0_error_percent = 100*abs(verification(index).w0_error/verification(index).w0_avg);
            index = index + 1;
        end
    end
end

