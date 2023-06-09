clc
clear
close all

c = 1; %speed of water in m/s

xmin = 0;
xmax = 20;
nx = 100; %number of datapoints

ymin = 0;
ymax = 20;
ny = nx; %making it a square makes some off the plotting later easier

tmax = 2;%no t min, as starting at 0
nt = nx;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);
dt = (tmax)/(nt-1);

x = xmin:dx:xmax;
y = ymin:dy:ymax;
t = 0:dt:tmax;


u = zeros(nx,ny,nt);%creating 3d array containing the amplitudes for a given x,y,t

for q =1:nt
    for i = 2:nx %just messing about with loops atm
        u(i,q,q) = nx*q;
    end
end


for q = 1:nt
    surf(x,y,u(1:100,1:100,q)) %plotting the plane at t=0
    title('Numerical Solution',q)
    xlabel('X')
    ylabel('Y')
    zlabel("U")
    drawnow;
end



