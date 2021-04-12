clear;
close all;

max_dphi = 1.5; % upper bound on the first derivative
max_ddphi = 6.5; % upper bound on the second derivative
Ts = 0.001; % sampling time
res_enc = 2*pi/3000; % resolution of the encoder
motor_direction = -1; % change motor direction
coulomb_feedforward_coeff = 0; % feedforward gain for coulomb friction model
motor_cutoff_angle = 70 * pi/180;

% Additional leg weights
pos_weight_1 = 0;
pos_weight_2 = 0;

% Sinusoid
ref_frequency = 0.5;
ref_amplitude = 4;

% Controller
Kp = 15;
Kd = 0.1;
enable_motor = 0;

% 1 = Robust Exact Differentiator
% 2 = Savitzky–Golay filter
% 3 = None;
filter_switch = 1;

% Robust exact differentiation
red_alpha = 1.1;
red_lambda = 1.5;

% Savitzky–Golay filter
savgol_k = 2; % filter order
savgol_m = 150; % filter length



