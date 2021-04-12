function value = obj(p, tspan, x0, time_data, angle_data, w_n)
    [time, position, ~] = simulate(tspan, x0, [p, w_n]);

    zero_crossings = estimate_zero_crossings([time, position]);
    zero_crossings_data = estimate_zero_crossings([time_data, angle_data]);

    length_zero_opt = length(zero_crossings);
    length_zero_data = length(zero_crossings_data);

    if length_zero_opt == 0
        value = Inf;
    elseif length_zero_opt < length_zero_data
        value = sum((zero_crossings_data(1:length_zero_opt)-zero_crossings).^2);
    elseif length_zero_opt > length_zero_data
        value = sum((zero_crossings_data(1:length_zero_data)-zero_crossings(1:length_zero_data)).^2) + sum((zero_crossings_data(end)-zero_crossings(length_zero_data+1:end)).^2);
    else 
        value = sum((zero_crossings_data-zero_crossings).^2);
    end
end

%% Simulate passive pendulum
function [time, position, velocity] = simulate(tspan, x0, p)
    f_v = p(1);
    f_c = p(2);
%     f_v = 2*p(1)*p(3);
%     f_c = p(2)*p(3)^2;
    w_n = p(3);

    [time, xout] = ode45(@(t,x) damped_oscilliator_RHS(t, x, [f_v, f_c, w_n]), tspan, x0);
    position = xout(:,1);
    velocity = xout(:,2);
end

%% Equation of motion
function x_dot = damped_oscilliator_RHS(t, x, p)
    q = x(1);
    Dq = x(2);

    f_v = p(1); % Viscous friction
    f_c = p(2); % Columb friction
    w_n = p(3); % Natural frequency

    k = 10000; % Approximate signum as arctan
    DDq = -f_v*Dq - f_c * 2*atan(k*Dq)/pi - w_n^2*sin(q);

    x_dot = [Dq; DDq];
end