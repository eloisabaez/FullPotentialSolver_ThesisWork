clear; clc; close all

map = [147 112 219
        0   0   200
        60  100 230
        120 155 242
        176 224 230
        32  178 170
        154 205 50
        46  139 87
        245 230 190
        222 184 135
        255 225 0
        255 165 0
        255 69  0
        178 34  34
        255 182 193
        255 20  147] ./ 255;

heat_capacity_ratio = 1.4;
free_stream_speed_of_sound = 340.0; % m/s

free_stream_mach_number = 0.65:0.05:1.0;
% free_stream_mach_number = 0.6;

for i = 1:length(free_stream_mach_number)
    
    free_stream_velocity = free_stream_mach_number(i) * free_stream_speed_of_sound;

    M_infty_sq = free_stream_mach_number(i) * free_stream_mach_number(i);

    q_infty_sq = free_stream_velocity * free_stream_velocity;

    velocity_sq = (0:1:700) .* (0:1:700);
    % velocity_sq = 2;
    % velocity_sq = 27882.72;
    %velocity_sq = 232356.000000000;

    Q = 1 + 0.5*(heat_capacity_ratio - 1) * M_infty_sq * (1 - velocity_sq./q_infty_sq);
    
    local_mach_sq = M_infty_sq * (velocity_sq./q_infty_sq) .* (1./Q);
    
    derivative_consts = 0.5 * (heat_capacity_ratio - 1) * (1/q_infty_sq) * M_infty_sq;
    dM2_dq2 = local_mach_sq .* ((1./velocity_sq) + derivative_consts.*(1./Q));
    
    txt = ['M_{\infty} = ', num2str(free_stream_mach_number(i))];
    plot(sqrt(local_mach_sq), dM2_dq2, 'DisplayName', txt, 'LineWidth',1.2, 'Color',map(i,:))
    hold on
    
end

set(gcf,'Color','w')
set(gca,'FontSize',14)
grid on
xlabel('$M_{local} [-]$','Interpreter','latex','FontSize',12)
ylabel('$\frac{\partial M_{e}^2}{\partial |q|_{e}^2} [s^2/m^2]$','Interpreter','latex','FontSize',16)
title('Mach Number Derivative','FontSize',18)
legend show
legend('Location','Northwest','FontSize',14)

% sq_max_local_mach_number = 3.0;
% sq_free_stream_velocity = (free_stream_speed_of_sound * free_stream_mach_number)^2;
% sq_free_stream_mach = free_stream_mach_number * free_stream_mach_number;
% 
% sq_max_velocity = sq_max_local_mach_number * sq_free_stream_velocity * ...
%             ((sq_free_stream_mach * heat_capacity_ratio - sq_free_stream_mach + 2) / ...
%             (sq_free_stream_mach * heat_capacity_ratio * sq_max_local_mach_number ...
%             - sq_max_local_mach_number * sq_free_stream_mach + 2 * sq_free_stream_mach));

        
velocity_sq = 232356.000000000;
Q = 1 + 0.5*(heat_capacity_ratio - 1) * M_infty_sq * (1 - velocity_sq./q_infty_sq);
c_sq = free_stream_speed_of_sound * free_stream_speed_of_sound * Q;




