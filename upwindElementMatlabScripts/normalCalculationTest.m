clear; clc; close all

% point_one =   [-1, -1];
% point_two =   [1, -1];
% point_three = [1, 1];

point_one =   [0, 0];
point_two =   [1, 0];
point_three = [1, 1];

%plot points
plot(point_one(1),point_one(2),'.','MarkerSize',20,'Color','r')
hold on
plot(point_two(1), point_two(2),'.','MarkerSize',20,'Color','b')
plot(point_three(1), point_three(2),'.','MarkerSize',20,'Color','g')

% plot lines
plot([point_one(1), point_two(1)], [point_one(2), point_two(2)],'Color','k')
plot([point_three(1), point_two(1)], [point_three(2), point_two(2)],'Color','k')
plot([point_one(1), point_three(1)], [point_one(2), point_three(2)],'Color','k')

% create vectors
% 2 - 1
vector_one   = [point_two(1) - point_one(1), point_two(2)-point_one(2),0];
% 3 - 2
vector_two   = [point_three(1) - point_two(1), point_three(2)-point_two(2),0];
% 1 - 3
vector_three = [point_one(1) - point_three(1), point_one(2)-point_three(2),0];

% cross products
% z axis
z = [0 0 1];

% first normal
x_one = vector_one(2)*z(3) - vector_one(3)*z(2);
y_one = -(vector_one(1)*z(3) - vector_one(3)*z(1));
z_one = vector_one(1)*z(2) - vector_one(2)*z(1);
normal_one = [x_one, y_one, z_one];

plot([point_one(1),point_one(1) + normal_one(1)], [point_one(2),point_one(2) + normal_one(2)],'Color','m')

% second normal
x_two = vector_two(2)*z(3) - vector_two(3)*z(2);
y_two = -(vector_two(1)*z(3) - vector_two(3)*z(1));
z_two = vector_two(1)*z(2) - vector_two(2)*z(1);
normal_two = [x_two, y_two, z_two];

plot([point_two(1),point_two(1) + normal_two(1)], [point_two(2),point_two(2) + normal_two(2)],'Color','m')

% third normal
x_three = vector_three(2)*z(3) - vector_three(3)*z(2);
y_three = -(vector_three(1)*z(3) - vector_three(3)*z(1));
z_three = vector_three(1)*z(2) - vector_three(2)*z(1);
normal_three = [x_three, y_three, z_three];

plot([point_three(1),point_three(1) + normal_three(1)], [point_three(2),point_three(2) + normal_three(2)],'Color','m')
axis([-3 3 -3 3])
set(gcf, 'Color','w'); grid on

% create vectors
% 1 - 2
vector_one   = [point_one(1) - point_two(1), point_one(2) - point_two(2), 0];
% 2 - 3
vector_two   = [point_two(1) - point_three(1), point_two(2) - point_three(2), 0];
% 3 - 1
vector_three = [point_three(1) - point_one(1), point_three(2) - point_one(2), 0];

% cross products
% z axis
z = [0 0 1];

% first normal
x_one = vector_one(2)*z(3) - vector_one(3)*z(2);
y_one = -(vector_one(1)*z(3) - vector_one(3)*z(1));
z_one = vector_one(1)*z(2) - vector_one(2)*z(1);
normal_one = [x_one, y_one, z_one];

plot([point_one(1),point_one(1) + normal_one(1)], [point_one(2),point_one(2) + normal_one(2)],'Color','y')

% second normal
x_two = vector_two(2)*z(3) - vector_two(3)*z(2);
y_two = -(vector_two(1)*z(3) - vector_two(3)*z(1));
z_two = vector_two(1)*z(2) - vector_two(2)*z(1);
normal_two = [x_two, y_two, z_two];

plot([point_two(1),point_two(1) + normal_two(1)], [point_two(2),point_two(2) + normal_two(2)],'Color','y')

% third normal
x_three = vector_three(2)*z(3) - vector_three(3)*z(2);
y_three = -(vector_three(1)*z(3) - vector_three(3)*z(1));
z_three = vector_three(1)*z(2) - vector_three(2)*z(1);
normal_three = [x_three, y_three, z_three];

plot([point_three(1),point_three(1) + normal_three(1)], [point_three(2),point_three(2) + normal_three(2)],'Color','y')


%%

% 
% %plot points
% plot(point_one(1),point_one(2),'.','MarkerSize',20,'Color','r')
% hold on
% plot(point_two(1), point_two(2),'.','MarkerSize',20,'Color','b')
% plot(point_three(1), point_three(2),'.','MarkerSize',20,'Color','g')
% 
% % plot lines
% plot([point_one(1), point_two(1)], [point_one(2), point_two(2)],'Color','k')
% plot([point_three(1), point_two(1)], [point_three(2), point_two(2)],'Color','k')
% plot([point_one(1), point_three(1)], [point_one(2), point_three(2)],'Color','k')
% 
% % create vectors
% % 2 - 1
% vector_one   = [point_two(1) - point_one(1), point_two(2)-point_one(2),0];
% % 3 - 2
% vector_two   = [point_three(1) - point_two(1), point_three(2)-point_two(2),0];
% % 1 - 3
% vector_three = [point_one(1) - point_three(1), point_one(2)-point_three(2),0];
% 
% % cross products
% % z axis
% z = [0 0 1];
% 
% % first normal
% x_one = vector_one(2)*z(3) - vector_one(3)*z(2);
% y_one = -(vector_one(1)*z(3) - vector_one(3)*z(1));
% z_one = vector_one(1)*z(2) - vector_one(2)*z(1);
% normal_one = [x_one, y_one, z_one];
% 
% plot([point_one(1),point_one(1) + normal_one(1)], [point_one(2),point_one(2) + normal_one(2)],'-.','Color','c')
% 
% % second normal
% x_two = vector_two(2)*z(3) - vector_two(3)*z(2);
% y_two = -(vector_two(1)*z(3) - vector_two(3)*z(1));
% z_two = vector_two(1)*z(2) - vector_two(2)*z(1);
% normal_two = [x_two, y_two, z_two];
% 
% plot([point_two(1),point_two(1) + normal_two(1)], [point_two(2),point_two(2) + normal_two(2)],'-.','Color','c')
% 
% % third normal
% x_three = vector_three(2)*z(3) - vector_three(3)*z(2);
% y_three = -(vector_three(1)*z(3) - vector_three(3)*z(1));
% z_three = vector_three(1)*z(2) - vector_three(2)*z(1);
% normal_three = [x_three, y_three, z_three];
% 
% plot([point_three(1),point_three(1) + normal_three(1)], [point_three(2),point_three(2) + normal_three(2)],'-.','Color','c')
% axis([-3 3 -3 3])
% set(gcf, 'Color','w'); grid on

% % create vectors
% % 1 - 2
% vector_one   = [point_one(1) - point_two(1), point_one(2) - point_two(2), 0];
% % 2 - 3
% vector_two   = [point_two(1) - point_three(1), point_two(2) - point_three(2), 0];
% % 3 - 1
% vector_three = [point_three(1) - point_one(1), point_three(2) - point_one(2), 0];
% 
% % cross products
% % z axis
% z = [0 0 1];
% 
% % first normal
% x_one = vector_one(2)*z(3) - vector_one(3)*z(2);
% y_one = -(vector_one(1)*z(3) - vector_one(3)*z(1));
% z_one = vector_one(1)*z(2) - vector_one(2)*z(1);
% normal_one = [x_one, y_one, z_one];
% 
% plot([point_one(1),point_one(1) + normal_one(1)], [point_one(2),point_one(2) + normal_one(2)],'-.','Color','g')
% 
% % second normal
% x_two = vector_two(2)*z(3) - vector_two(3)*z(2);
% y_two = -(vector_two(1)*z(3) - vector_two(3)*z(1));
% z_two = vector_two(1)*z(2) - vector_two(2)*z(1);
% normal_two = [x_two, y_two, z_two];
% 
% plot([point_two(1),point_two(1) + normal_two(1)], [point_two(2),point_two(2) + normal_two(2)],'-.','Color','g')
% 
% % third normal
% x_three = vector_three(2)*z(3) - vector_three(3)*z(2);
% y_three = -(vector_three(1)*z(3) - vector_three(3)*z(1));
% z_three = vector_three(1)*z(2) - vector_three(2)*z(1);
% normal_three = [x_three, y_three, z_three];
% 
% plot([point_three(1),point_three(1) + normal_three(1)], [point_three(2),point_three(2) + normal_three(2)],'-.','Color','g')
