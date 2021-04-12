clear

m_w = 2*0.182;      % mass of weights
m_f = 2*0.005;      % mass of fixtures
j_w = 0.000264942;  % two times inertia from central weights
l_h = 0.03;         % distance between holes
l_s = 0.2;          % distance to first hole
g = 9.81;

n_weight = 0:8;
[n1, n2] = meshgrid(n_weight);

for i = 1:length(n1)
    for j = 1:length(n2)
        if n1(i,j) < 1
            J_weights(i,j) = 0;
            tau_weights(i,j) = 0;
        else
            J_weights(i,j) = j_w + (m_w + m_f)*(l_s + l_h/2 + (n1(i,j)-1)*l_h)^2 ;
            tau_weights(i,j) = (m_w + m_f)*g*(l_s + l_h/2 + (n1(i,j)-1)*l_h);
        end
        
        if n2(i,j) >= 1
            J_weights(i,j) = J_weights(i,j) + (j_w + (m_w + m_f)*(l_s + l_h/2 + (n2(i,j)-1)*l_h)^2);
            tau_weights(i,j) = tau_weights(i,j) + ((m_w + m_f)*g*(l_s + l_h/2 + (n2(i,j)-1)*l_h));
        end
    end
end

kkp = 4;
mgl = 6.5;
J = 0.2;

omega_0 = sqrt((mgl + tau_weights)./(J_weights + J) + kkp);  

% A(end+1,:) = [1 -w0_avg^2+k(end)*kp];
% b(end+1,1) = w0_avg^2*J_weights-tau_weights-k(end)*kp*J_weights;


close all
figure
% hold on
% plot(n_weight, J_weights,'-d')
% plot(n_weight, tau_weights, '-o')
% legend('J','tau')
% surface(n1, n2, J_weights);
% 
% figure
% surface(n1, n2, tau_weights);

surface(n1,n2,omega_0);
hold on;
plot3(diag(n1),diag(n2),diag(omega_0));
