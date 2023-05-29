%/ define coordinates /%
xmin = -100;    % adjust bounds as desired
xmax = 400;
nx = 450;
ymin = -50;
ymax = 50;
ny = 450;

dx = (xmax - xmin)/(nx-1);
dy = (ymax - ymin)/(ny-1);
x = xmin:dx:xmax;
y = ymin:dy:ymax;
[X, Y] = meshgrid(x, y);


%/ determine height Z /%
z=0;    
n=101; % this is number of time intervals we are looking at
finaltime=10; % this is "how long" the simulation runs for. At finaltime=0, boat is at origin.  
times=linspace(0,finaltime,n); % now we will look at the wave released at each t=times  
boatspeed=20;
for i=1:21%looping over certain wavelengths - only one wavelength for now
    k=i; % this is the actual value for wavelength we will be using
    omega=sqrt(9.81.*k);
    phasevel=sqrt(9.81./k); %
    groupvel=0.5*phasevel;
    for j=1:n
        t=times(j);
        r=sqrt((X-boatspeed*t).^2+(Y).^2); %distance from boat position at time t
        maxdistance=groupvel*(finaltime-t);
        z=z+cos(k.*r-omega*(finaltime-t));
        if r>=maxdistance %delete the contributions that don't physically make sense
            z=z-cos(k.*r-omega*(finaltime-t));
        end
    end
end

surf(X,Y,z)
