close all
clear


addpath ../functions

load('test.mat');

Dx_lin = @(x, p) [x(2); -p(1)*x(2) - p(2) * 2*atan(100000*x(2))/pi - p(3)^2*(x(1))];  
Dx_nonlin = @(x, p) [x(2); -p(1)*x(2) - p(2) * 2*atan(100000*x(2))/pi - p(3)^2*sin(x(1))];  

% p_test = [0.1, 0.2, 4];
% x0 = [1, 0];
% tspan = [0 20];
% [time_nonlin_sim, yout_nonlin_sim] = ode45(@(t,y) Dx_nonlin(y,p_test), tspan, x0);
% angle_nonlin_sim = yout_nonlin_sim(:,1);

angle_nonlin_sim = angle;
time_nonlin_sim = time;
x0 = [angle(1); (angle(2)-angle(1))/(time(2)-time(1))];
tspan = time;

[pks, i_p] = findpeaks((angle_nonlin_sim), 'MinPeakHeight', pi/180);
i_0 = i_p(find(pks < 14*pi/180, 1, 'first'));

angle_lin = angle_nonlin_sim(i_0:end);
time_lin = time_nonlin_sim(i_0:end);

MPH = 2*pi/180;
MPD = 1;
[pks, t_p] = findpeaks(angle_lin, time_lin, 'MinPeakHeight', MPH, 'MinPeakDistance', MPD);
[vllys, t_v] = findpeaks(-angle_lin, time_lin, 'MinPeakHeight', MPH, 'MinPeakDistance', MPD);
% [pks, t_p] = findpeaks(angle_nonlin_sim, time_nonlin_sim);
% [vllys, t_v] = findpeaks(-angle_nonlin_sim, time_nonlin_sim);
vllys = -vllys;



Y = zeros(length(vllys)+length(pks),1); 

if t_p(1) < t_v(1)
    Y(1:2:2*length(pks)-1) = pks;
    Y(2:2:2*length(vllys)) = vllys;
else
    Y(1:2:2*length(vllys)-1) = vllys;
    Y(2:2:2*length(pks)) = pks;
end

for i = 3:length(Y)-1
    e = (Y(i+1) - Y(i-1))/(Y(i) - Y(i-2));
    b(i-2) = -log(-e)/pi;
end

b_avg = sum(b)/length(b);
zeta = sqrt(b_avg^2/(1+b_avg^2));

for i = 2:length(Y)-1
    xk(i-1) = (Y(i+1)-Y(i) + exp(-b_avg*pi)*(Y(i)-Y(i-1)))/(2*(-1)^(-i)*(exp(-b_avg*pi)+1));
end

xk_avg = sum(xk)/length(xk);

zc_lin = estimate_zero_crossings([time_lin, angle_lin], 0);
T = diff(zc_lin);
if mod(length(T),2) == 1
    T = T(1:end-1);
end

T = T(1:2:end)+T(2:2:end);

median_T = median(T);
for i = length(T):-1:1
    if T(i)<0.9*median_T || T(i) > 1.1*median_T
        T(i) = [];
    end
end


T_avg = sum(T)/length(T);

w_d = 2*pi/T_avg;
w_n_0 = w_d/sqrt(1-zeta^2);

% options = optimoptions(@fmincon,'Algorithm', 'sqp', 'Display','iter-detailed', 'TolFun', 1e-10, 'TolX', 1e-10);
options = optimoptions(@fmincon, 'Display','iter-detailed', 'TolFun', 1e-10, 'TolX', 1e-10);
% options = optimset('Display','iter-detailed', 'TolFun', 1e-10, 'TolX', 1e-10);
lower_bound = 0.5*w_n_0;
upper_bound = 1.5*w_n_0;
p0 = w_n_0;
tspan_opt = time_lin;
x0_opt = [angle_lin(1), (angle_lin(2)-angle_lin(1))/(time_lin(2)-time_lin(1))];
% w_n = fmincon(@(w) obj([zeta, xk_avg], tspan_opt, x0_opt, time_lin, angle_lin ,w), p0, [], [], [], [], lower_bound, upper_bound, [], options);
w_n = fmincon(@(w) obj([2*zeta*p0, xk_avg*p0^2], tspan, x0, time_nonlin_sim, angle_nonlin_sim ,w), p0, [], [], [], [], lower_bound, upper_bound, [], options);
% w_n = fminsearch(@(w) obj([zeta, xk_avg], tspan_opt, x0_opt, time_lin, angle_lin ,w), p0, options);
% w_n = fminsearch(@(w) obj([zeta, xk_avg], tspan_opt, x0_opt, time_lin, angle_lin ,w), w_n, options);

f_v = 2*zeta*w_n;
f_c = xk_avg*w_n^2;

p_verify = [f_v; f_c; w_n]
[time_verify, yout_verify] = ode45(@(t,y) Dx_nonlin(y,p_verify), tspan, x0);
% [time_verify, yout_verify] = ode45(@(t,y) Dx_nonlin(y,p_verify), tspan_opt, x0_opt);
angle_verify = yout_verify(:,1);

figure 
hold on
plot(time_nonlin_sim, angle_nonlin_sim)
plot(time_verify, angle_verify,':')
legend('data', 'verify');
hold off

