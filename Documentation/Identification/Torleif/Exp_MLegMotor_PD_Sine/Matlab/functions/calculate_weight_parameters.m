function measurement_data = calculate_weight_parameters(measurement_data)
    m_w = 2*0.182;      % mass of weights
    m_f = 2*0.005;      % mass of fixtures
    j_w = 0.000264942;  % two times inertia from central weights
    l_h = 0.03;         % distance between holes
    l_s = 0.2;          % distance to first hole
    g = 9.81;

    for i = 1:length(measurement_data)
        n_weight = measurement_data(i).n_weights;
        for k = 1:length(n_weight)
            if n_weight(k) == 0
                measurement_data(i).J_weights(k) = 0;
                measurement_data(i).tau_weights(k) = 0;
            else
                measurement_data(i).J_weights(k) = j_w + (m_w + m_f)*(l_s + l_h/2 + (n_weight(k)-1)*l_h)^2;
                measurement_data(i).tau_weights(k) = (m_w + m_f)*g*(l_s + l_h/2 + (n_weight(k)-1)*l_h);
            end
        end
    end
end

