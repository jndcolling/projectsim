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
for i=1:21 % looping over certain wavelengths 
    k=i; % this is the actual value for wavelength we will be using
    omega=sqrt(9.81.*k);
    phasevel=sqrt(9.81./k); %using deep water dispersion relations
    groupvel=0.5*phasevel;
    for j=1:n
        t=times(j); % At time t, we will now attenpt to add contribution from disturbance created at boat position
        r=sqrt((X-boatspeed*t).^2+(Y).^2); % distance from boat position at time t
        maxdistance=groupvel*(finaltime-t); % this is the furthest the wave could have travelled 
        z=z+cos(k.*r-omega*(finaltime-t)); % add contribution for the pattern at final time
        if r>=maxdistance % delete the contributions that don't physically make sense
            z=z-cos(k.*r-omega*(finaltime-t));
        end
    end
end

surf(X,Y,z)
