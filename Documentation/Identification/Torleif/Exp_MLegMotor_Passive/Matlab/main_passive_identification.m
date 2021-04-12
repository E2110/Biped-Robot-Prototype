%% Preamble
close all;
clear
clc

addpath functions
addpath classes
    
import = true; 
import_path = '../Saved/';

if import
    load([import_path 'saved_data.mat']);
else
    recorded_data_path = '../Data/';
    parameter_path = '../../Parameters/';
    
    data_handler = ExperimentHandler(recorded_data_path, parameter_path);
    data_handler.filter_data();
    data_handler.estimate_encoder_data_shift();
    data_handler.find_parameters();
    data_handler.verify_estimated_parameters();

    save([import_path 'saved_data.mat'], 'data_handler'); 
end

close all
weight_pos_index = 2;
for i = 1:length(data_handler.sorted_experiments(weight_pos_index).experiments)
    experiment = data_handler.sorted_experiments(weight_pos_index).experiments(i);
    
    figure
    hold on
    plot(experiment.filtered_time, (180/pi)*experiment.filtered_angle);
    plot(experiment.encoder_time, (180/pi)*experiment.encoder_angle);
    plot(experiment.estimated_time, (180/pi)*experiment.estimated_angle,':');
    legend('Filtered angle', 'Encoder angle', 'Estimated angle');
    title(['Experiment ' num2str(i) ', Weight Position (' num2str(data_handler.sorted_experiments(weight_pos_index).weight_pos(1)) ',' num2str(data_handler.sorted_experiments(weight_pos_index).weight_pos(2)) ')']);
    hold off
end
