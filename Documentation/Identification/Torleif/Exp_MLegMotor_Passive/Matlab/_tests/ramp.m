function signal = ramp(ramp_toggle)
    persistent ramp_direction ramp_value
    
    if isempty(ramp_direction)
        ramp_direction = 0;
        ramp_value = 0;
    end
    
    if ramp_toggle
        if ramp_value == 0
            ramp_direction = 1;
        elseif ramp_value == 1;
            ramp_direction = -1;
        end
    else
        ramp_value = ramp_value + ramp_direction*0.02;
        
        if ramp_value < 0
            ramp_value = 0;
            ramp_direction = 0;
        elseif ramp_value > 1
            ramp_value = 1;
            ramp_direction = 0;
        end
    end

    signal = ramp_value;
end

