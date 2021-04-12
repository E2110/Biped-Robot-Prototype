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