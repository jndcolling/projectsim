figure
xlim([-10 10])    % limits of axes
ylim([-10 10])

%/ define coordinates /%
xmin = -20;
xmax = 2;
nx = 100;

ymin = -20;
ymax = 20;
ny = nx;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);

x = xmin:dx:xmax;
y = ymin:dy:ymax;

[X, Y] = meshgrid(x, y);

for p = 1:10
    l = p / 5;
    %/ define Z /%
    r = sqrt(X.^2 + Y.^2);    % radius
    %l = 1;    % wavelength
    k = 2 * pi / l;    % wave number
    Z = sin(k*r);
    surf(X,Y,Z)
    v = 1;    % speed of the boat
    c = sqrt(9.81 * l / (2 * pi));    % speed of the wave
    
    for t = 1:10
        r = sqrt((X-v*t).^2+Y.^2);
        Z = Z + sin(k*r);
        %pause(1)    % wait 1 second before next iteration
        surf(X,Y,Z)
    end
end