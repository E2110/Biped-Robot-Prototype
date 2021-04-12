function wd_estimates = find_phase_crossing(freq_data, phase_data)
    % Calculates resonance frequency based on phase crossing -90 degrees

    phase_data = phase_data - (-90*pi/180);
    
    prev_sign = 0;
    wd_estimates = [];
    for i=1:length(phase_data)
        current_sign = sign(phase_data(i));
        if current_sign ~= prev_sign && prev_sign ~= 0
            x1 = freq_data(i-1);
            x2 = freq_data(i);
            y1 = phase_data(i-1);
            y2 = phase_data(i);
            crossing = (x2*y1-x1*y2)/(y1-y2);
            wd_estimates = [wd_estimates; crossing];
        end
        prev_sign = current_sign;
    end
end

