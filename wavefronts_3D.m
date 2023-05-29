%/ define coordinates /%
xmin = 0;    % adjust bounds as desired
xmax = 60;
nx = 300;
ymin = -60;
ymax = 60;
ny = nx;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);
x = xmin:dx:xmax;
y = ymin:dy:ymax;
[X, Y] = meshgrid(x, y);

%/ determine height Z /%
Z = 0;      % initialise height Z
g = 9.81;
for p = 1:500        % looping 200 times to get 200 different frequencies
    w = p / 30;      % define each frequency w
    k = w^2 / g;     % wavenumber, found from dispersion relation
    cp = sqrt(g/k);  % phase velocity of wave
    cg = 0.5 * cp;   % group velocity of wave
    v = 1.9;    % speed of the boat
    tmax = 40;  % number of seconds to loop t over
    tdivide = 20; % just to get smaller intervals
    for t = 0:tmax    % loop for 50 time intervals
        max_distance = cg * (tmax - t);
        tprime = t/tdivide;    % divide t to get smaller intervals
        r = sqrt((X-v*tprime).^2+Y.^2);    % distance from boat's position
        if r > max_distance    % if we exceed the max distance
            r = 0;             % set r and w to 0, so the contribution to Z
            w = 0;             % is also 0
        end
        Z = Z + sin(k*r - w*(tmax/tdivide - tprime));    % add new Z part
    end
end
surf(X,Y,Z)    % plot