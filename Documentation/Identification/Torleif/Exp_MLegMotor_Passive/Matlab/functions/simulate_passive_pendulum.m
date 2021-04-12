%% Simulate passive pendulum
function [time, position, velocity] = simulate_passive_pendulum(sim_init)
    [time, xout] = ode45(@(t,x) damped_oscilliator(t, x, sim_init.param), sim_init.tspan, sim_init.x0);
    position = xout(:,1);
    velocity = xout(:,2);
end

%% Equation of motion
function x_dot = damped_oscilliator(t, x, param)
    q = x(1);
    Dq = x(2);

    % f_v - Viscous friction
    % f_c - Columb friction
    % w_n - Natural frequency

    k = 10000; % Approximate signum as arctan
    DDq = -param.f_v*Dq - param.f_c * 2*atan(k*Dq)/pi - param.w_n^2*sin(q);

    x_dot = [Dq; DDq];
end