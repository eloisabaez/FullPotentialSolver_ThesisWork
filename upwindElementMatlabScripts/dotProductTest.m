clear; clc; close all

arrowheadsize = 1.0;
linewidtharrows = 1.8;

point_one =   [0, 0];
point_two =   [10, 0];
point_three = [10, 10];

%plot points
plot(point_one(1),point_one(2),'.','MarkerSize',20,'Color','k')
hold on
plot(point_two(1), point_two(2),'.','MarkerSize',20,'Color','k')
plot(point_three(1), point_three(2),'.','MarkerSize',20,'Color','k')
text(-0.5,-0.5,'1','FontSize',14)
text(10.5,-0.5,'2','FontSize',14)
text(10.5,10.5,'3','FontSize',14)

% plot lines
% plot([point_one(1), point_two(1)], [point_one(2), point_two(2)],'Color','k','Linewidth',1.2)
% plot([point_three(1), point_two(1)], [point_three(2), point_two(2)],'Color','k','Linewidth',1.2)
% plot([point_one(1), point_three(1)], [point_one(2), point_three(2)],'Color','k','Linewidth',1.2)

% % create vectors
% % 1 - 2
% vector_one   = [point_one(1) - point_two(1), point_one(2) - point_two(2), 0];
% % 2 - 3
% vector_two   = [point_two(1) - point_three(1), point_two(2) - point_three(2), 0];
% % 3 - 1
% vector_three = [point_three(1) - point_one(1), point_three(2) - point_one(2), 0];

% create vectors
% 1 - 2
vector_one   = [point_two(1) - point_one(1), point_two(2) - point_one(2), 0];
% 2 - 3
vector_two   = [point_three(1) - point_two(1), point_three(2) - point_two(2), 0];
% 3 - 1
vector_three = [point_one(1) - point_three(1), point_one(2) - point_three(2), 0];

% quiver(point_two(1),point_two(2),vector_one(1),vector_one(2),0,'Color','k','LineWidth',1.2,'MaxHeadSize',0.15)
% quiver(point_three(1),point_three(2),vector_two(1),vector_two(2),0,'Color','k','LineWidth',1.2,'MaxHeadSize',0.15)
% quiver(point_one(1),point_one(2),vector_three(1),vector_three(2),0,'Color','k','LineWidth',1.2,'MaxHeadSize',0.15)

quiver(point_one(1),point_one(2),vector_one(1),vector_one(2),0,'Color','k','LineWidth',1.2,'MaxHeadSize',0.15)
quiver(point_two(1),point_two(2),vector_two(1),vector_two(2),0,'Color','k','LineWidth',1.2,'MaxHeadSize',0.15)
quiver(point_three(1),point_three(2),vector_three(1),vector_three(2),0,'Color','k','LineWidth',1.2,'MaxHeadSize',0.15)

axis([-2.5 11.5 -2.5 11.5])
set(gcf, 'Color','w'); 
axis off;

% cross products
% z axis
z = [0 0 1];

% first normal
x_one = vector_one(2)*z(3) - vector_one(3)*z(2);
y_one = -(vector_one(1)*z(3) - vector_one(3)*z(1));
z_one = vector_one(1)*z(2) - vector_one(2)*z(1);

normal_one = [x_one, y_one, z_one];
normal_one = normal_one ./ norm(normal_one);

midpoint_one = [0.5*(point_one(1) + point_two(1)), 0.5*(point_one(2) + point_two(2))];
quiver(midpoint_one(1),midpoint_one(2),normal_one(1),normal_one(2),0,...
    'Color','#e37222','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)

% second normal
x_two = vector_two(2)*z(3) - vector_two(3)*z(2);
y_two = -(vector_two(1)*z(3) - vector_two(3)*z(1));
z_two = vector_two(1)*z(2) - vector_two(2)*z(1);

normal_two = [x_two, y_two, z_two];
normal_two = normal_two ./ norm(normal_two);

midpoint_two = [0.5*(point_two(1) + point_three(1)), 0.5*(point_two(2) + point_three(2))];
quiver(midpoint_two(1),midpoint_two(2),normal_two(1),normal_two(2),0,...
    'Color','#0065bd','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)


% third normal
x_three = vector_three(2)*z(3) - vector_three(3)*z(2);
y_three = -(vector_three(1)*z(3) - vector_three(3)*z(1));
z_three = vector_three(1)*z(2) - vector_three(2)*z(1);

normal_three = [x_three, y_three, z_three];
normal_three = normal_three ./ norm(normal_three);

midpoint_three = [0.5*(point_one(1) + point_three(1)), 0.5*(point_one(2) + point_three(2))];
quiver(midpoint_three(1),midpoint_three(2),normal_three(1),normal_three(2),0,...
    'Color','#a2ad00','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)

% free stream velocity 
free_stream_mach_number = 0.6;
free_stream_speed_of_sound = 340.0;
V = [free_stream_mach_number * free_stream_speed_of_sound, 0, 0];

quiver(-2,0,V(1)/norm(V(1)),0,0,'Color','#999999','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)
quiver(-2,2,V(1)/norm(V(1)),0,0,'Color','#999999','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)
quiver(-2,4,V(1)/norm(V(1)),0,0,'Color','#999999','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)
quiver(-2,6,V(1)/norm(V(1)),0,0,'Color','#999999','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)
quiver(-2,8,V(1)/norm(V(1)),0,0,'Color','#999999','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)
quiver(-2,10,V(1)/norm(V(1)),0,0,'Color','#999999','LineWidth',linewidtharrows,'MaxHeadSize',arrowheadsize)
text(-1.75,10.75,'q_{\infty}','FontSize',14)

component_one = dot(normal_one,V)/norm(V);
component_two = dot(normal_two,V)/norm(V);
component_three = dot(normal_three,V)/norm(V);
