figure
xlim([-10 10])    % limits of axes
ylim([-10 10])

%/ define coordinates /%
xmin = -10;
xmax = 10;
nx = 100;

ymin = -10;
ymax = 10;
ny = nx;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);

x = xmin:dx:xmax;
y = ymin:dy:ymax;

[X, Y] = meshgrid(x, y);

%/ define Z /%
r = sqrt(X.^2 + Y.^2);    % radius
l = 1;    % wavelength
k = 2 * pi / l;    % wave number
Z = sin(k*r);
surf(X,Y,Z)
v = 1;    % speed of the boat

for t = 1:10
    r = sqrt((X-v*t).^2+Y.^2);
    Z = Z + sin(k*r);
    pause(1)    % wait 1 second before next iteration
    surf(X,Y,Z)
end