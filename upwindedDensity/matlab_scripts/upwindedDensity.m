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
M_crit = 0.99;
upwind_factor_constant = 1.0;

local_V = 0.7*free_stream_speed_of_sound:1:360;

upwind_factor = zeros(1,length(local_V));
local_mach = zeros(1,length(local_V));

upwinded_density = zeros(1,length(local_V));

upwind_velocity = 0:100:500;
upwind_density = zeros(1,length(upwind_velocity));
density = zeros(length(upwind_velocity),length(local_V));

for j = 1:length(upwind_velocity)
    % upwind element
    sq_upwind_local_velocity = clampLocalVelocity(sq_max_velocity, upwind_velocity(j)^2);

    sq_upwind_speed_of_sound = calculateLocalSpeedOfSound(free_stream_mach_number, ...
            free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, sqrt(sq_upwind_local_velocity));

    sq__upwind_local_mach_number = calculateLocalMachNumber(sq_upwind_speed_of_sound, sqrt(sq_upwind_local_velocity));

    upwind_density(j) = calculateDensity(free_stream_mach_number, free_stream_velocity, heat_capacity_ratio, free_stream_density, sqrt(sq_upwind_local_velocity));
    
    upwind_element_factor = 0;
    if (sq__upwind_local_mach_number ~= 0)
        upwind_element_factor = upwind_factor_constant * (1.0 - M_crit^2 / sq__upwind_local_mach_number);
    end
    
    for i = 1:length(local_V)
        % current element
        sq_clamped_local_velocity = clampLocalVelocity(sq_max_velocity, local_V(i)^2);

        sq_clamped_speed_of_sound = calculateLocalSpeedOfSound(free_stream_mach_number, ...
                free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, sqrt(sq_clamped_local_velocity));

        sq__clamped_local_mach_number = calculateLocalMachNumber(sq_clamped_speed_of_sound, sqrt(sq_clamped_local_velocity));

        density(1,i) = calculateDensity(free_stream_mach_number, free_stream_velocity, heat_capacity_ratio, free_stream_density, sqrt(sq_clamped_local_velocity));
        
        % upwinded density
        upwind_factor(i) = upwind_factor_constant * (1.0 - M_crit^2 / sq__clamped_local_mach_number);
        
        max_upwind_factor = max([upwind_factor(i), upwind_element_factor, 0]);
        
        upwinded_density(i) = calculateUpwindedDensity(density(1,i), max_upwind_factor, upwind_density(j));
        
        local_mach(i) = sqrt(sq__clamped_local_mach_number);

    end
    txt_rho_up = ['Upwinded Density, ', '\rho_{up} = ', num2str(upwind_density(j)), ', q_{up} = ', num2str(upwind_velocity(j))];
    plot(local_mach, upwinded_density, 'DisplayName', txt_rho_up, 'LineWidth',1.75, 'Color', map(j,:))
    hold on
end

plot(local_mach, density(1,:), 'DisplayName', 'Not Upwinded Density', 'LineWidth',1.2, 'LineStyle', '--', 'Color','k')
xline(M_crit,'LineWidth',1.75,'LineStyle',':','Color','k','DisplayName','M_{crit}')

set(gcf,'Color','w')
% set(gcf, 'PaperUnits', 'Centimeters', 'PaperSize', [10, 30]);
set(gca,'FontSize',14)
% axis([0 4 0 1.2])
grid on;
ylabel('$\rho\,[kg/m^3]$','Interpreter','latex','FontSize',18)
xlabel('$M_{local}\,[-]$','Interpreter','latex','FontSize',18)
title('Density','FontSize',18)
legend show
legend('Location','EastOutside','FontSize',10)


% figure
% plot(upwind_velocity, upwind_density)

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