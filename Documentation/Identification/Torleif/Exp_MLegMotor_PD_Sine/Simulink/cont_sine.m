function [y, dy] = cont_sine(t, w, A)
    persistent w0 phi;
    
    if isempty(w0)
        w0 = w;
        phi = 0;
    end
    
    if w0 ~= w
        phi = mod((w0-w)*t(1) + phi, 2*pi);
        w0 = w;
    end
    
    y = A*sin(2*pi*w0*t + phi);
    dy = 2*pi*w0*A*cos(2*pi*w0*t + phi);
end

