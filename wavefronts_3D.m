%/ define coordinates /%
xmin = 0;    % adjust bounds as desired
xmax = 17;
nx = 600;
ymin = -10;
ymax = 10;
ny = 150;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);
x = xmin:dx:xmax;
y = ymin:dy:ymax;
[X, Y] = meshgrid(x, y);

%/ determine height Z /%
h = 20;                % water depth
Z = 0;                  % initialise height Z
g = 9.81;               % gravitational acceleration
v = 0.5;                  % speed of the boat
l = 0.25/(9.81 * 0.5);     % length of the boat
Fr = v / sqrt(g*l);     % Froude number
sigma = 0.072;          % surface tension https://www.engineeringtoolbox.com/water-surface-tension-d_597.html
rho = 1000;             % density of water
k_0 = 2 * pi / l;
w_0 = sqrt(g*k_0);                     % for deep water
%w_0 = sqrt(g*k_0*tanh(k_0*h));          % for shallow water
%w_0 = sqrt((k_0*g + sigma*k_0^3/rho) * tanh(k_0*h));  % for surface tension
k_divider = 20;         % to get smaller increments of k
dt = 0.05;              % time interval
tmax = 300;              % final time to iterate to
for k = k_0/6:k_0*6     % set up many iterations for k
    %k = p/k_divider ;      % define each wavenumber using the divider

    %/ general dispersion relation (surface tension and depth considered)
    %w = sqrt((k*g + sigma*k^3/rho) * tanh(k*h));
    %cp = w / k;
    %cg = ((g + 3*sigma*k^2/rho) * tanh(k*h) + (k*g + sigma*k^3/rho) / (cosh(k*h))^2) / (2*w);

    %/  shallow-depth dispersion relation
    %w = sqrt(g*k*tanh(k*h));     % frequency, found from general dispersion relation
    %cp = sqrt(g/k.*tanh(k.*h));  % phase velocity of wave
    %cg =  0.5*cp.*(1+(h*k)./(cosh(k*h).*sinh(k*h)));   % group velocity of wave
   
    %/ deep water relation
    w = sqrt(g*k); 
    cp= sqrt(g/k);
    cg= 0.5*cp;
    
    % amplitude of the wave produced - assumed to be gaussian distributed
    %A = sqrt(exp(-w^2*v/g));    %/ in the article it uses this gaussian specifically
    A = exp(-v*(w-w_0)^2/g);    %/ adjusted to be centred on w_0 – defined for the wavelength equal to boat length

    for i = 0:tmax                      % loop from initial time to final time
        t = i * dt;
        max_distance = cg * (tmax*dt - t);    % max distance a wave can travel
        
        %/ For a single point boat
        r = sqrt((X-t).^2+(Y).^2);       % distance from boat position 
        Z = Z - A*sin(k*r.*(r<max_distance) - w*(tmax*dt - t)/(v*dt).*(r<max_distance));    % add new Z part if feasible https://uk.mathworks.com/matlabcentral/answers/474717-mesh-surf-plot-of-function-with-if-statements
        % may sometimes need to subtract from Z. Unclear why.

        %/ For a boat consisting of four moving points
%        r1 = sqrt((X-v*t).^2+(Y+4).^2);    % distance from boat's position
%        r2 = sqrt((X-v*t).^2+(Y-4).^2);
%        r3 = sqrt((X-v*t+10).^2+(Y+4).^2);    % distance from boat's position
%        r4 = sqrt((X-v*t+10).^2+(Y-4).^2);
%        Z = Z - A*sin(k*r1.*(r1<max_distance) - w*(tmax - t).*(r1<max_distance));  % add new Z part if feasible https://uk.mathworks.com/matlabcentral/answers/474717-mesh-surf-plot-of-function-with-if-statements
%        Z = Z - A*sin(k*r2.*(r2<max_distance) - w*(tmax - t).*(r2<max_distance));
%        Z = Z - A*sin(k*r3.*(r3<max_distance) - w*(tmax - t).*(r3<max_distance));  % add new Z part if feasible https://uk.mathworks.com/matlabcentral/answers/474717-mesh-surf-plot-of-function-with-if-statements
%        Z = Z - A*sin(k*r4.*(r4<max_distance) - w*(tmax - t).*(r4<max_distance));
    end
end
surf(X,Y,Z)    % plot
disp(Fr)
alpha = atand((sqrt(2*pi*Fr^2 - 1)) / (4*pi*Fr^2 - 1));
disp(alpha)
