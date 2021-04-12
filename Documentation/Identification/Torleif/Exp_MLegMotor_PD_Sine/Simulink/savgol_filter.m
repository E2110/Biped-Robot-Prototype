function [Y, dY] = savgol_filter(y, k, m, h)
    % y - the current data sample
    % k - the order of the polynominal
    % m - length of filter (created m+1 coefficients)
    % h - time between data samples

    persistent buffer C filter_config;
    
    if isempty(buffer)
        buffer = zeros(m,1);
        C = savgol_coeffs(k, m, 0, h);
        filter_config = [m, k];
    end
    
    if any(filter_config ~= [m, k])
        if filter_config(1) > m
            buffer = buffer(filter_config(1)-(m-1):filter_config(1));
        elseif filter_config(1) < m
            temp = zeros(m, 1);
            temp(length(temp)-(m-1):m) = buffer;
            buffer = temp;
        end
        C = savgol_coeffs(k, m, 0, h);
        filter_config = [m, k];
    end

    buffer(1:m-1) = buffer(2:m);
    buffer(m) = y;

    Y = dot(C(1,:), buffer);
    dY = dot(C(2,:), buffer);
end

function a = savgol_coeffs(k, m_L, m_R, h)
    z_i = -m_L:m_R;
    J = zeros(length(z_i), k+1);
    
    for i=1:length(z_i)
        J(i,:) = z_i(i).^(0:k);
    end
    
    C = (J'*J)\(J');
    a = [C(1,:); C(2,:)/h];
end

