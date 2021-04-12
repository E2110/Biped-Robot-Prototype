function parameters = estimate_lumped_parameters(measurement_data, method)
    switch(method)
        case 1
            % Estimating parameters using Km curve and full resonance
            A = [];
            b = [];
            a = [];

            for i = 1:length(measurement_data)
                if ~isempty(measurement_data(i).km_curve)
                    J_weights = sum(measurement_data(i).J_weights);
                    tau_weights = sum(measurement_data(i).tau_weights);

                    for j = 1:length(measurement_data(i).experiments)
                        w0_avg = measurement_data(i).experiments(j).w0_avg;
                        kp = measurement_data(i).experiments(j).kp;
                        a(end+1) = measurement_data(i).km_curve(1);

                        A(end+1,:) = [1 -w0_avg^2 + a(end)*kp];
                        b(end+1,1) = w0_avg^2*J_weights-tau_weights-a(end)*kp*J_weights;
                    end
                end
            end
            
            x = A\b;
            
            Km = [];

            for i = 1:length(measurement_data)
                    if ~isempty(measurement_data(i).km_curve)
                        J_weights = sum(measurement_data(i).J_weights);

                        for j = 1:length(measurement_data(i).experiments)
                            Km(end+1) = measurement_data(i).km_curve(1) * (x(2)+J_weights);
                        end
                    end
            end

            parameters.mgl = x(1);
            parameters.J = x(2);
            parameters.Km = sum(Km)/length(Km); 

        case 2
            % Estimating parameters using Km curve only
            A = [];
            b = [];

            for i = 1:length(measurement_data)
                if ~isempty(measurement_data(i).km_curve)
                    k0 = measurement_data(i).km_curve(2);
                    J_weights = sum(measurement_data(i).J_weights);
                    tau_weights = sum(measurement_data(i).tau_weights);

                    A(end+1,:) = [1 -k0];
                    b(end+1,1) = J_weights*k0-tau_weights;
                end
            end

            x = A\b;
            
            Km = [];

            for i = 1:length(measurement_data)
                    if ~isempty(measurement_data(i).km_curve)
                        J_weights = sum(measurement_data(i).J_weights);

                        for j = 1:length(measurement_data(i).experiments)
                            Km(end+1) = measurement_data(i).km_curve(1) * (x(2)+J_weights);
                        end
                    end
            end

            parameters.mgl = x(1);
            parameters.J = x(2);
            parameters.Km = sum(Km)/length(Km); 
            
        case 3
            % Estimating Km directly in LS
            A = [];
            b = [];
            
            for i = 1:length(measurement_data)
                J_weights = sum(measurement_data(i).J_weights);
                tau_weights = sum(measurement_data(i).tau_weights);

                for j = 1:length(measurement_data(i).experiments)
                    w0_avg = measurement_data(i).experiments(j).w0_avg;
                    kp = measurement_data(i).experiments(j).kp;

                    A(end+1,:) = [1 -w0_avg^2 kp];
                    b(end+1,1) = w0_avg^2*J_weights-tau_weights;
                end
            end
            
            x = A\b;
            
            parameters.mgl = x(1);
            parameters.J = x(2);
            parameters.Km = x(3); 
    end
end

