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
free_stream_density = 1.225;
free_stream_speed_of_sound = 340.3; % m/s
free_stream_mach_number = 0.6;
free_stream_velocity = free_stream_mach_number * free_stream_speed_of_sound;
sq_limit_mach_number = 3.0;
sq_max_velocity = calculateMaximumVelocity(free_stream_mach_number, free_stream_velocity, heat_capacity_ratio, sq_limit_mach_number);
upwind_factor_constant = 1.0;

M_crit = 0.9:0.01:1.0;

local_V = 0.7*free_stream_speed_of_sound:1:360;

upwind_factor = zeros(1,length(local_V));
local_mach = zeros(1,length(local_V));

yline(0,'Color', 'k', 'LineStyle','--','LineWidth',1,'DisplayName','\mu_{f} = 0')
hold on

for j = 1:length(M_crit)
    for i = 1:length(local_V)
        sq_clamped_local_velocity = clampLocalVelocity(sq_max_velocity, local_V(i)^2);

        sq_clamped_speed_of_sound = calculateLocalSpeedOfSound(free_stream_mach_number, ...
                free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, sqrt(sq_clamped_local_velocity));

        sq__clamped_local_mach_number = calculateLocalMachNumber(sq_clamped_speed_of_sound, sqrt(sq_clamped_local_velocity));

        local_mach(i) = sqrt(sq__clamped_local_mach_number);

        upwind_factor(i) = upwind_factor_constant * (1.0 - M_crit(j)^2 / sq__clamped_local_mach_number);
    end
    txt = ['M_{crit} = ', num2str(M_crit(j))];
    plot(local_mach, upwind_factor, 'DisplayName', txt, 'LineWidth',1.5, 'Color', map(j,:))
    hold on
end

set(gcf,'Color','w')
set(gca,'FontSize',14)
grid on;
ylabel('$\mu_{f} [-]$','Interpreter','latex','FontSize',16)
xlabel('$M_{local} [-]$','Interpreter','latex','FontSize',16)
title('$\mu_{f} = \mu_{c} (1 - M^2_{crit}/M^2_{local})$','Interpreter','latex','FontSize',18)
legend show
legend('Location','Southeast','FontSize',14)

% % clamped
% sq_clamped_local_velocity = clampLocalVelocity(sq_max_velocity, local_V^2);
% 
% sq_clamped_speed_of_sound = calculateLocalSpeedOfSound(free_stream_mach_number, ...
%         free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, sqrt(sq_clamped_local_velocity));
% 
% sq__clamped_local_mach_number = calculateLocalMachNumber(sq_clamped_speed_of_sound, sqrt(sq_clamped_local_velocity));
% 
% upwind_factor = 1.0 * (1.0 - 0.94^2 / sq__clamped_local_mach_number);
% 
% % upwind
% upwind_V = sqrt(76093.2); 
% % clamped
% sq_clamped_upwind_velocity = clampLocalVelocity(sq_max_velocity, upwind_V^2);
% 
% sq_clamped_upwind_speed_of_sound = calculateLocalSpeedOfSound(free_stream_mach_number, ...
%         free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, sqrt(sq_clamped_upwind_velocity));
% 
% sq_clamped_upwind_mach_number = calculateLocalMachNumber(sq_clamped_upwind_speed_of_sound, upwind_V);
% 
% upwind_upwind_factor = 1.0 * (1.0 - 0.94^2 / sq_clamped_upwind_mach_number);

%%
function sq_speed_of_sound = calculateLocalSpeedOfSound(fs_M, fs_A, fs_V, fs_H_C, local_V)
    square_bracket_term = 1 + 0.5*(fs_H_C - 1)*fs_M^2*(1-(local_V/fs_V)^2);
    sq_speed_of_sound = fs_A^2 * square_bracket_term;
end

function density = calculateDensity(fs_M, fs_V, fs_H_C, fs_Rho, local_V)
    square_bracket_term = 1 + 0.5*(fs_H_C - 1)*fs_M^2*(1-(local_V/fs_V)^2);
    density = fs_Rho * square_bracket_term^(1/(fs_H_C - 1));
end

function sq_local_mach_number = calculateLocalMachNumber(sq_local_A, local_V)
    sq_local_mach_number = local_V^2 / sq_local_A;
end

function sq_max_velocity = calculateMaximumVelocity(fs_M, fs_V, fs_H_C, sq_limit_M)
    sq_fs_V = fs_V * fs_V;
    sq_fs_M = fs_M * fs_M;
    sq_max_velocity = sq_limit_M * sq_fs_V * ((sq_fs_M * fs_H_C - sq_fs_M + 2)/(sq_fs_M * fs_H_C * sq_limit_M - sq_limit_M * sq_fs_M + 2 * sq_fs_M));
end

function sq_clamped_local_velocity = clampLocalVelocity(sq_max_velocity, sq_local_velocity)
    if (sq_local_velocity > sq_max_velocity)
        sq_local_velocity = sq_max_velocity;
    end
    
    sq_clamped_local_velocity = sq_local_velocity;
end