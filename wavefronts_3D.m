%/ define coordinates /%
xmin = 0;    % adjust bounds as desired
xmax = 350;
nx = 600;
ymin = -100;
ymax = 100;
ny = 200;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);
x = xmin:dx:xmax;
y = ymin:dy:ymax;
[X, Y] = meshgrid(x, y);

%/ determine height Z /%
h = 0.1;
Z = 0;      % initialise height Z
g = 9.81;
v = 8;    % speed of the boat
l = 25;     % length of the boat
Fr = v / sqrt(g*l);    % Froude number
k_0 = 2 * pi / l;
w_0 = sqrt(g*k_0);
k_divider = 50;
tmax = 35;  % final time
for p = 30:1000   % set up 1000 iterations
    k = p/k_divider ;      % define each wavenumber 

    %  general dispersion relation
%    w = sqrt(g*k*tanh(k*h));     % frequency, found from general dispersion relation
%    cp = sqrt(g/k.*tanh(k.*h));  % phase velocity of wave
%    cg =  0.5*cp.*(1+(h*k)./(cosh(k*h).*sinh(k*h)));   % group velocity of wave
   
    % deep water relation
    w = sqrt(g*k); 
    cp= sqrt(g/k);
    cg= 0.5*cp;
    
    % amplitude of the wave produced - assumed to be gaussian distributed
    % (in the article it uses this gaussian specifically)
    %A = sqrt(exp(-w^2*v/g));
    %A = sqrt(exp(-((k-k_0)*v)^2));
    A = sqrt(exp(-v*(w-w_0)^2/g));

    for i = 0:tmax    % loop from initial time to final time
        t = i;
        max_distance = cg * (tmax - t); % max distance a wave can travel
        
        % Single point source code
       r = sqrt((X-v*t).^2+(Y).^2); % distance from boat position 
       Z = Z - A*sin(k*r.*(r<max_distance) - w*(tmax - t).*(r<max_distance));    % add new Z part if feasible https://uk.mathworks.com/matlabcentral/answers/474717-mesh-surf-plot-of-function-with-if-statements
        % btw. the negative is me cheating. the surface was upside down for some reason

        % 4 moving point sources
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
