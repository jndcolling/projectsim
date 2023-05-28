%/ define coordinates /%
xmin = -40;    % adjust bounds as desired
xmax = 40;
nx = 300;
ymin = 10;
ymax = 50;
ny = nx;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);
x = xmin:dx:xmax;
y = ymin:dy:ymax;
[X, Y] = meshgrid(x, y);

%/ determine height Z /%

for p = 1:200      % looping 200 times to get 200 different frequencies
    w = p / 20;    % define each frequency w
    k = w^2 / 9.81;    % wavenumber, found from dispersion relation
    v = 1.5;    % speed of the boat
    Z = 0;      % initialise height Z
    for t = 0:50    % loop for 50 time intervals
        tprime = t/20;    % divide t to get smaller intervals
        r = sqrt((X+v*tprime).^2+Y.^2);    % distance from boat's position
        Z = Z + sin(k*r);    % add new wave to the existing Z
    end
end
surf(X,Y,Z)    % plot