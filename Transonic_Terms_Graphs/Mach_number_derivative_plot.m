clear; clc; close all

heat_capacity_ratio = 1.4;
free_stream_speed_of_sound = 340; % m/s

% free_stream_mach_number = 0.65:0.05:1.0;
free_stream_mach_number = 0.65;

for i = 1:length(free_stream_mach_number)
    
    free_stream_velocity = free_stream_mach_number(i) * free_stream_speed_of_sound;

    M_infty_sq = free_stream_mach_number(i) * free_stream_mach_number(i);

    q_infty_sq = free_stream_velocity * free_stream_velocity;

    % velocity_sq = (0:1:700) .* (0:1:700);
    velocity_sq = 2;

    Q = 1 + 0.5*(heat_capacity_ratio - 1) * M_infty_sq * (1 - velocity_sq./q_infty_sq);
    
    local_mach_sq = M_infty_sq * (velocity_sq./q_infty_sq) .* (1./Q);
    
    derivative_consts = 0.5 * (heat_capacity_ratio - 1) * (1/q_infty_sq) * M_infty_sq;
    dM2_dq2 = local_mach_sq .* ((1./velocity_sq) + derivative_consts.*(1./Q));
    
    txt = ['M_{\infty} = ', num2str(free_stream_mach_number(i))];
    plot(sqrt(local_mach_sq), dM2_dq2, 'DisplayName', txt, 'LineWidth',0.9)
    hold on
    
end

set(gcf,'Color','w')
grid on
xlabel('$M_{local} [-]$','Interpreter','latex','FontSize',12)
ylabel('$\frac{\partial M_{e}^2}{\partial |q|_{e}^2} [-]$','Interpreter','latex','FontSize',16)
title('Mach Number Derivative')
legend show
legend('Location','Northwest')




