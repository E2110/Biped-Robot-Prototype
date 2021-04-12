
function [ p_hat, v_hat, xi, p_meas_hat, v_meas_hat, Pd] = step_tmo(...
           Ts, r_b, f_b_IMU, y_PosRef, y_VeloRef, .....
           p_n_prev, v_n_prev, xi_prev, b_a_hat, R_nb_hat, sigma_prev, omega_ib_b_hat_,...
           omega_ie_n, g_0, Pd, Ad, Cd, Q, R, theta,....
           b_acc_bias_feedback, b_use_mahoney_, b_new_pos_ref_ )
            
% Constants
I_3 = eye(3);
z_3 = zeros(3);
z_31 = zeros(3,1);        
        
% Allocation TMO
p_hat = p_n_prev;
v_hat = v_n_prev;
xi = xi_prev; 

%% Attitude related params
sigma_hat = sigma_prev;

C_PosRef = I_3;
if b_use_mahoney_ == true
    xi_scale = 0;
else
    xi_scale = 1;
end

%% generate state space
x_ = [  p_hat; v_hat; xi ];
I_n = eye( size(x_, 1) );

%% pos meas only
% y = y_PosRef;
% y_hat = Cd*x_ + C_PosRef*R_nb_hat*r_b;

%% pos + velo meas
y = [y_PosRef;  y_VeloRef;];
omega_n_nb_hat = omega_ib_b_hat_ - R_nb_hat'*omega_ie_n;
S_omega_nb_b = Smtrx(omega_n_nb_hat);
y_hat = [Cd*x_ + [C_PosRef*R_nb_hat*r_b;  C_PosRef*R_nb_hat*S_omega_nb_b*r_b] ];

y_tilde = y - y_hat;

if (b_new_pos_ref_)
    Rd = R;
    Kd = Pd*Cd'/(Cd*Pd*Cd' + Rd);
    x_hat = x_ + Kd*y_tilde;
    P_cor = I_n - Kd*Cd;
    P_hat = P_cor*Pd*P_cor' + Kd*R*Kd';
else
    x_hat = x_;
    P_hat = Pd;
end

Bd =  [ Ts^2/2*R_nb_hat     Ts^3/6*R_nb_hat;
        Ts*R_nb_hat         Ts^2/2*R_nb_hat;
        z_3                 Ts*R_nb_hat;
];

S_omega_ie_n = Smtrx(omega_ie_n);
g_n = [0; 0; g_0];
v_hat = x_hat(5:7);
D0 = -2*S_omega_ie_n*v_hat+g_n;
Dd = [  Ts^2/2*D0;
        Ts*D0;
        z_31;
        ];

% calulate input
if b_acc_bias_feedback == true
    u = [   (f_b_IMU-b_a_hat);
        -Smtrx(sigma_hat)*(f_b_IMU-b_a_hat)*xi_scale
    ];
else
    u = [   (f_b_IMU);
        -Smtrx(sigma_hat)*(f_b_IMU)*xi_scale
    ]; 
end
x_ = Ad*x_hat + Bd*u + Dd;
Pd = Ad*P_hat*Ad' + Bd*Q*Bd'; 

p_hat = x_(1:3);
v_hat = x_(4:6);
xi = x_(7:9)*xi_scale;

p_meas_hat = p_hat + R_nb_hat*r_b; % output

omega_n_nb_hat = omega_ib_b_hat_ - R_nb_hat'*omega_ie_n;
S_omega_nb_b = Smtrx(omega_n_nb_hat);
v_meas_hat = (v_hat + R_nb_hat*S_omega_nb_b*r_b);  % output
