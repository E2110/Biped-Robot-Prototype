function measurement_data = estimate_resonance(measurement_data)
    %% Estimate resonance frequency
    for i = 1:length(measurement_data)
        for j = 1:length(measurement_data(i).experiments)
            for k = 1:length(measurement_data(i).experiments(j).run)
                run = measurement_data(i).experiments(j).run(k);
                magnitude = zeros(length(run.data),1);
                phase = zeros(size(magnitude));
                freq = zeros(size(magnitude));
                
                for m = 1:length(run.data)
                    data = run.data(m);
                    reference = data.ref_angle;
                    measurement = data.filter_angle;

                    time = data.time;
                    N = length(time);               % number of samples
                    Ts = (time(end) - time(1))/N;   % sample time
                    Fs = 1/Ts;                      % sample frequency
                    ref_FFT = fft(reference);       % fft of reference signal
                    meas_FFT = fft(measurement);    % fft of response signal
                    amplitudeResp = max(abs(meas_FFT(1:floor(N/2)))/floor(N/2));
                    amplitudeRef = max(abs(ref_FFT(1:floor(N/2)))/floor(N/2));

                    amplitudeResponse = amplitudeResp/amplitudeRef;
                    magnitude(m) = 20*log(amplitudeResponse);

                    phaseShiftRad = angle(meas_FFT(1:floor(N/2))/ref_FFT(1:floor(N/2)));
                    phase(m) = phaseShiftRad;

                    freq(m) = data.ref_frequency;
                end

                w0_estimate = 2*pi*find_phase_crossing(freq, phase);
                if ~isempty(w0_estimate)
                    w0_estimate = w0_estimate(1);
                end

                measurement_data(i).experiments(j).run(k).bode_magnitude = magnitude;
                measurement_data(i).experiments(j).run(k).bode_phase = phase;
                measurement_data(i).experiments(j).run(k).bode_frequency = freq;
                measurement_data(i).experiments(j).run(k).w0_estimate = w0_estimate;
            end
            
            valid_runs = [measurement_data(i).experiments(j).run.valid];
            n_runs = length(measurement_data(i).experiments(j).run);
            measurement_data(i).experiments(j).w0_avg = sum([measurement_data(i).experiments(j).run(valid_runs).w0_estimate])/n_runs;
            measurement_data(i).experiments(j).w0_var = sum(([measurement_data(i).experiments(j).run(valid_runs).w0_estimate]- measurement_data(i).experiments(j).w0_avg).^2)/n_runs;
        end
    end
end

