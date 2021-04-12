close all;

i_end = 1500;

i = 1;

time = measurement_data(1).experiments(1).run(1).data(i).time(1:i_end);
encoder_angle = measurement_data(1).experiments(1).run(1).data(i).encoder_angle(1:i_end);
filter_angle = measurement_data(1).experiments(1).run(1).data(i).filter_angle(1:i_end);
filter_velocity = measurement_data(1).experiments(1).run(1).data(i).filter_velocity(1:i_end);
ref_angle = measurement_data(1).experiments(1).run(1).data(i).ref_angle(1:i_end);
ref_velocity = measurement_data(1).experiments(1).run(1).data(i).ref_velocity(1:i_end);

figure;
hold on;
stairs(time,encoder_angle);
plot(time,filter_angle);
plot(time,ref_angle);
hold off;
% title();
xlabel('Time (s)');
ylabel('Angle (\theta)');
legend('Encoder angle','Filtered angle','Reference angle')


% figure;
% hold on;
% stairs(time,encoder_angle);
% plot(time,filter_angle);
% hold off

close all
% plot_bode(measurement_data)
