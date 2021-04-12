function [ q_hat, euler_hat, b_gyro_b_hat, sigma_hat, omega_ib_b_hat, R_nb_hat] = step_attitude_quat(...
           Ts,....
           f_b_IMU, omega_IMU,....
           s_attiude_sensor, b_new_head_meas, ...
           q_prev, b_gyro_b_hat_prev, R_nb_hat_prev, euler_hat_prev,....
           f_n_hat, b_acc_b_hat, omega_ie_n,...
           k_1, k_2, kI, Mb, Mbh, b_acc_bias_feedback, b_use_mahoney)

% Allocation
q_hat = q_prev;
b_gyro_b_hat = b_gyro_b_hat_prev;
R_nb_hat = R_nb_hat_prev;
euler_hat = euler_hat_prev;

%% Constants
I_3 = eye(3);
I_4 = eye(4);

%% Acceleromter related params
if b_acc_bias_feedback == true
    f_b_norm = (f_b_IMU - b_acc_b_hat)/norm(f_b_IMU - b_acc_b_hat); 
else
    f_b_norm = f_b_IMU/norm(f_b_IMU);
end

if b_use_mahoney
    f_n_norm = [0; 0; -1];
else
    f_n_norm = f_n_hat/norm(f_n_hat);
end

%% meas and ref vectors
v_1_b = f_b_norm;
v_1_n = f_n_norm;
switch (s_attiude_sensor.type) 
    case 'mag'
        m_b_mag = s_attiude_sensor.meas;
        m_nb_n = s_attiude_sensor.ref; 
        v_2_b = m_b_mag/norm(m_b_mag);
        v_2_n = m_nb_n/norm(m_nb_n);
    case 'compass' 
        psi_comp = s_attiude_sensor.meas;
        c_n = s_attiude_sensor.ref;
        R_nb_meas = Rzyx(euler_hat(1), euler_hat(2), psi_comp);
        v_2_b = R_nb_meas'*c_n;
        v_2_n = c_n;
end

%% Prediction
v_1_b_hat = R_nb_hat'*v_1_n;
v_2_b_hat = R_nb_hat'*v_2_n;

if b_new_head_meas == true
    heading_scale = (s_attiude_sensor.delta_t_heading)/Ts;
else
    heading_scale = 0;
end

%% Injection term
sigma_hat = k_1*cross(v_1_b, v_1_b_hat) + ....
           heading_scale*k_2*cross(v_2_b, v_2_b_hat);                

omega_ib_b_hat = omega_IMU - b_gyro_b_hat + sigma_hat;

%% Specific quaternion integration
A_omega = [   0, -omega_ib_b_hat';
            omega_ib_b_hat, -Smtrx(omega_ib_b_hat)];
A_omega_ien = [0, -omega_ie_n';
                omega_ie_n, Smtrx(omega_ie_n)];

norm_omega_ib_b_hat = norm(omega_ib_b_hat);
norm_omega_ien = norm(omega_ie_n);
q_hat = (cos(Ts*norm_omega_ib_b_hat)*I_4+Ts/2*sinc(Ts*norm_omega_ib_b_hat/2)*A_omega)/...
        (cos(Ts*norm_omega_ien)*I_4+Ts/2*sinc(Ts*norm_omega_ien/2)*A_omega_ien)*q_hat;

%% Euler integration
% q_hat = q_hat + Ts*0.5*Theta*q_hat;
% q_hat = q_hat/norm(q_hat);

%% Quternion normalization 
q_hat = q_hat/norm(q_hat);

%% Gyro bias estimation
beta = -kI*sigma_hat;
b_hat_square = b_gyro_b_hat'*b_gyro_b_hat;
if b_hat_square > Mb^2 && b_gyro_b_hat'*beta > 0
    c = min([1, (b_hat_square-Mb^2)/(Mbh^2-Mb^2)]);
    b_hat_dot = (I_3 - c*(b_gyro_b_hat*b_gyro_b_hat')/b_hat_square)*beta;
else
    b_hat_dot = beta;
end
b_gyro_b_hat = b_gyro_b_hat + Ts*b_hat_dot;


%% Rotation matrix output
R_nb_hat = Rquat(q_hat);

%% Euler angles output
[euler_hat(1), euler_hat(2), euler_hat(3)] = R2euler(R_nb_hat);