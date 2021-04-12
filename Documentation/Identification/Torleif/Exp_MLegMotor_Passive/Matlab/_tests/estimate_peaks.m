function measurement_data = estimate_peaks( measurement_data, peak_threshold)
    for i = 1:length(measurement_data)
        for j = 1:length(measurement_data(i).experiments)
            [pks, locs] = findpeaks(measurement_data(i).experiments(j).encoder_angle, 'MinPeakHeight', peak_threshold);
            
            measurement_data(i).experiments(j).peaks.value = pks;
            measurement_data(i).experiments(j).peaks.index = locs;
            
            
        end
    end
end

