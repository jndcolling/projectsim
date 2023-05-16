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

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);

x = xmin:dx:xmax;
y = ymin:dy:ymax;


