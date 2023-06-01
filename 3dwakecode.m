%/ define coordinates /%
xmin = 0;    % adjust bounds as desired
xmax = 300;
nx = 500;
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
v = 5;    % speed of the boat
tmax = 50;  % number of time periods to loop t over (not seconds)
tdivide = 5; % just to get smaller intervals
for p = 1:200        % looping 200 times to get 200 different frequencies
    w = p/20;      % define each frequency w
    k = w^2 / g;     % wavenumber, found from dispersion relation
    cp = sqrt(g/k);  % phase velocity of wave
    cg =  cp;   % group velocity of wave
    A = sqrt(exp(-k*v));    % amplitude of the wave produced
    for t = 0:tmax    % loop for 50 time intervals
        max_distance = cg * (tmax - t);
        r = sqrt((X-v*t).^2+Y.^2);    % distance from boat's position
        Z = Z + A * sin(k*r.*(r<max_distance) - w*(tmax - t).*(r<max_distance));  % add new Z part if feasible https://uk.mathworks.com/matlabcentral/answers/474717-mesh-surf-plot-of-function-with-if-statements
    end
end
pcolor(X,Y,Z)    % plot
%zlim([-50 30])    % limit range of z values
