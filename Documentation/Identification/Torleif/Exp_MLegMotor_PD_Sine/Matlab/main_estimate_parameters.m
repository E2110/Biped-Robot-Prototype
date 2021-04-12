% clear
close all;
addpath ../Matlab/functions

IMPORT_DATA = 1;
if IMPORT_DATA
    clear
    root_path = '../Data/Current';
    measurement_data = import_data(root_path);
    measurement_data = estimate_resonance(measurement_data);
    measurement_data = calculate_weight_parameters(measurement_data);
    measurement_data = estimate_km_curve_parameters(measurement_data);
%     save('formatted_data', 'measurement_data');
else
%     load('formatted_data');
end

% plot_bode(measurement_data);
% plot_km_curve(measurement_data);

for i = 1:3
    parameters = estimate_lumped_parameters(measurement_data, i);
    verification = verify_estimated_parameters(measurement_data, parameters);
    
    estimation_data(i).parameters = parameters;
    estimation_data(i).verification = verification;
end

print_estimation_data(estimation_data);



