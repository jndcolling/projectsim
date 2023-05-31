%/ define coordinates /%
xmin = 0;    % adjust bounds as desired
xmax = 90;
nx = 200;
ymin = -100;
ymax = 100;
ny = nx;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);
x = xmin:dx:xmax;
y = ymin:dy:ymax;
[X, Y] = meshgrid(x, y);

%/ determine height Z /%
Z = 0;      % initialise height Z
g = 9.81;
v = 1.5;    % speed of the boat
tmax = 300;  % number of time periods to loop t over (not seconds)
tdivide = 5; % just to get smaller intervals
for p = 1:300        % looping 200 times to get 200 different frequencies
    w = p / 3;      % define each frequency w
    k = w^2 / g;     % wavenumber, found from dispersion relation
    cp = sqrt(g/k);  % phase velocity of wave
    cg = 0.5 * cp;   % group velocity of wave
    A = exp(-k*v);    % amplitude of the wave produced
    for t = 0:tmax    % loop for 50 time intervals
        max_distance = cg * (tmax - t);
        tprime = t/tdivide;    % divide t to get smaller intervals
        r = sqrt((X-v*tprime).^2+Y.^2);    % distance from boat's position
        if r > max_distance    % if we exceed the max distance
            r = 0;             % set r and w to 0, so the contribution to Z
            w = 0;             % is also 0
        end
        Z = Z + A * sin(k*r - w*(tmax/tdivide - tprime));  % add new Z part
    end
end
surf(X,Y,Z)    % plot
%zlim([10 200])    % limit range of z values