% plot speed of sound vs local mach number
clear; clc; close all

heat_capacity_ratio = 1.4;
free_stream_density = 1.225;
free_stream_speed_of_sound = 340; % m/s
free_stream_mach_number = 0.94;
free_stream_velocity = free_stream_mach_number * free_stream_speed_of_sound;
sq_limit_mach_number = 3.0;
sq_max_velocity = calculateMaximumVelocity(free_stream_mach_number, free_stream_velocity, heat_capacity_ratio, sq_limit_mach_number);

local_V = (0:1:780);%sqrt(sq_max_velocity)+100);
sq_speed_of_sound = zeros(1,length(local_V));
sq_local_mach_number = zeros(1,length(local_V));
local_density = zeros(1,length(local_V));
sq_clamped_speed_of_sound = zeros(1,length(local_V));
sq__clamped_local_mach_number = zeros(1,length(local_V));
local_clamped_density = zeros(1,length(local_V));

for i = 1:length(local_V)
    % not clamped
    sq_speed_of_sound(i) = calculateLocalSpeedOfSound(free_stream_mach_number, ...
        free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, local_V(i));
    
    sq_local_mach_number(i) = calculateLocalMachNumber(sq_speed_of_sound(i), local_V(i));
    
    local_density(i) = calculateDensity(free_stream_mach_number, free_stream_velocity, heat_capacity_ratio, free_stream_density, local_V(i));
    
    % clamped
    sq_clamped_local_velocity = clampLocalVelocity(sq_max_velocity, local_V(i)^2);
    
    sq_clamped_speed_of_sound(i) = calculateLocalSpeedOfSound(free_stream_mach_number, ...
        free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, sqrt(sq_clamped_local_velocity));
    
    sq__clamped_local_mach_number(i) = calculateLocalMachNumber(sq_clamped_speed_of_sound(i), sqrt(sq_clamped_local_velocity));
    
    local_clamped_density(i) = calculateDensity(free_stream_mach_number,...
        free_stream_velocity, heat_capacity_ratio, free_stream_density, sqrt(sq_clamped_local_velocity));
end


plot(local_V, sq_local_mach_number,'Color','r','LineStyle','--','LineWidth',1.25)
hold on
plot(local_V, sq__clamped_local_mach_number,'Color','k','LineWidth',1.25)
set(gcf,'Color','w')
grid on
legend('Unclamped','Clamped','Location','Northwest')
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',12)
ylabel('$M_{local}^2 [-]$','Interpreter','latex','FontSize',16)
title('Mach Number')

figure
plot(local_V, sq_speed_of_sound,'Color','r','LineStyle','--','LineWidth',1.25)
hold on
plot(local_V, sq_clamped_speed_of_sound,'Color','k','LineWidth',1.25)
set(gcf,'Color','w')
grid on
legend('Unclamped','Clamped','Location','Northeast')
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',12)
ylabel('$a_{local}^2 [m^2/s^2]$','Interpreter','latex','FontSize',16)
title('Speed of Sound')

figure
plot(local_V, local_density,'Color','r','LineStyle','--','LineWidth',1.25)
hold on
plot(local_V, local_clamped_density,'Color','k','LineWidth',1.25)
set(gcf,'Color','w')
grid on
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',12)
ylabel('$\rho_{local} [kg/m^3]$','Interpreter','latex','FontSize',16)
title('Density')

figure
plot(local_V, local_clamped_density./free_stream_density,'Color','#0065bd','LineWidth',1.3)
hold on
plot(local_V, sq_clamped_speed_of_sound./free_stream_speed_of_sound^2,'Color','#e37222','LineWidth',1.3)
plot(local_V, sq__clamped_local_mach_number./free_stream_mach_number^2,'Color','#a2ad00','LineWidth',1.3)
set(gcf,'Color','w')
grid on
legend('\rho_{local}/\rho_{\infty} [-]','a_{local}^2/a_{\infty}^2 [-]','M_{local}^2/M_{\infty}^2 [-]',...
    'Location','Northwest','FontSize',14)
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',14)
title('Comparison of Values','FontSize',14)

%%

local_V = (0:10:1500);
sq_speed_of_sound = zeros(1,length(local_V));
sq_local_mach_number = zeros(1,length(local_V));
local_density = zeros(1,length(local_V));

for i = 1:length(local_V)
    sq_speed_of_sound(i) = calculateLocalSpeedOfSound(free_stream_mach_number, ...
        free_stream_speed_of_sound, free_stream_velocity, heat_capacity_ratio, local_V(i));
    
    sq_local_mach_number(i) = calculateLocalMachNumber(sq_speed_of_sound(i), local_V(i));
    
    local_density(i) = calculateDensity(free_stream_mach_number, free_stream_velocity, heat_capacity_ratio, free_stream_density, local_V(i));
end

figure
plot(local_V, sq_local_mach_number,'Color','k','LineWidth',1.25)
set(gcf,'Color','w')
grid on
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',12)
ylabel('$M_{local}^2 [-]$','Interpreter','latex','FontSize',16)
title('Mach Number')

figure
plot(local_V, sq_speed_of_sound,'Color','k','LineWidth',1.25)
set(gcf,'Color','w')
grid on
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',12)
ylabel('$a_{local}^2 [m^2/s^2]$','Interpreter','latex','FontSize',16)
title('Speed of Sound')

figure
plot(local_V, local_density,'Color','k','LineWidth',1.25)
set(gcf,'Color','w')
grid on
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',12)
ylabel('$\rho_{local} [kg/m^3]$','Interpreter','latex','FontSize',16)
title('Density')

figure
plot(local_V, local_density./free_stream_density,'Color','#0065bd','LineWidth',1.3)
hold on
plot(local_V, sq_speed_of_sound./free_stream_speed_of_sound^2,'Color','#e37222','LineWidth',1.3)
plot(local_V, sq_local_mach_number./free_stream_mach_number^2,'Color','#a2ad00','LineWidth',1.3)
set(gcf,'Color','w')
grid on
legend('\rho_{local}/\rho_{\infty}','a_{local}^2/a_{\infty}^2 [-]','M_{local}^2/M_{\infty}^2 [-]',...
    'Location','Northwest','FontSize',14)
xlabel('$q_{local} [m/s]$','Interpreter','latex','FontSize',14)
title('Comparison of Values','FontSize',14)

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