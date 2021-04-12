function zero_crossings = estimate_zero_crossings(data, data_shift, min_peak_height)
    if nargin == 3
        [~, index] = findpeaks(data(:,2), 'MinPeakHeight', min_peak_height);
        range = index(1):index(end);
        x_data = data(range,1);
        y_data = data(range,2);
    else
        x_data = data(:,1);
        y_data = data(:,2);
    end

    if nargin == 1
        data_shift = 0;
    end

    y_data = y_data - data_shift;

    prev_sign = 0;
    zero_crossings = [];
    for k = 1:length(y_data)
        current_sign = sign(y_data(k));
        if current_sign ~= prev_sign && prev_sign ~= 0
            x1 = x_data(k-1);
            x2 = x_data(k);
            y1 = y_data(k-1);
            y2 = y_data(k);
            crossing = (x2*y1-x1*y2)/(y1-y2);
            zero_crossings = [zero_crossings; crossing];
        end
        prev_sign = current_sign;
    end
end