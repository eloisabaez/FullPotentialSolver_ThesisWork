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

local_V = 0.8*free_stream_speed_of_sound:0.1:400;

local_mach = zeros(1,length(local_V));
dmu_dM2 = zeros(1,length(local_V));

for j = 1:length(M_crit)
    
    for i = 1:length(local_V)
        % current element
        sq_clamped_local_velocity = clampLocalVelocity(sq_max_velocity, local_V(i)^2);

        sq_clamped_speed_of_sound = calculateLocalSpeedOfSound(free_stream_mach_number, ...
                free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, sqrt(sq_clamped_local_velocity));

        sq__clamped_local_mach_number = calculateLocalMachNumber(sq_clamped_speed_of_sound, sqrt(sq_clamped_local_velocity));

        dmu_dM2(i) = 1.0 * M_crit(j)^2 / sq__clamped_local_mach_number^2;
        
        if (sq__clamped_local_mach_number < M_crit(j)^2)
            dmu_dM2(i) = 0;
        end
        
        local_mach(i) = sqrt(sq__clamped_local_mach_number);

    end
    txt = ['M_{crit} = ', num2str(M_crit(j))];
    plot(local_mach, dmu_dM2, 'DisplayName', txt, 'LineWidth',1.75, 'Color', map(j,:))
    hold on
end

set(gcf,'Color','w')
set(gca,'FontSize',14)
grid on;
ylabel('$\frac{\partial \mu_f}{\partial M^2} \,[-]$','Interpreter','latex','FontSize',20)
xlabel('$M_{local}\,[-]$','Interpreter','latex','FontSize',20)
title('$\frac{\partial \mu_f}{\partial M^2} = \mu_c \, \frac{M^2_{crit}}{M^4}$','Interpreter','latex','FontSize',22)
legend show
legend('Location','Northeast','FontSize',14)


%%
function sq_speed_of_sound = calculateLocalSpeedOfSound(fs_M, fs_A, fs_V, fs_H_C, local_V)
    square_bracket_term = 1 + 0.5*(fs_H_C - 1)*fs_M^2*(1-(local_V/fs_V)^2);
    sq_speed_of_sound = fs_A^2 * square_bracket_term;
end

function density = calculateDensity(fs_M, fs_V, fs_H_C, fs_Rho, local_V)
    square_bracket_term = 1 + 0.5*(fs_H_C - 1)*fs_M^2*(1-(local_V/fs_V)^2);
    density = fs_Rho * square_bracket_term^(1/(fs_H_C - 1));
end

function upwinded_density = calculateUpwindedDensity(density, upwind_factor, upwind_density)
    upwinded_density = density - upwind_factor * (density - upwind_density);
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