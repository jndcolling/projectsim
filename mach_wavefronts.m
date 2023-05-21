% using https://uk.mathworks.com/help/images/ref/viscircles.html
% alas, this only creates a Mach cone

figure
v = 1;    % speed of the boat
c = 1;    % speed of the wave
wave_sources = [0 0];    % list of all positions where the boat has been
xlim([0 50])    % limits of axes
ylim([-25 25])
%axis square
for t = 1:10
    boat_X = v*t;    % boat position, assume travelling x-direction only
    boat_Y = 0;
    boat_pos = [boat_X, boat_Y];
    wave_sources = [wave_sources; boat_pos];    % update with new boat pos.
    
    for i = 1:size(wave_sources, 1)    % loop through each row of the array
        centre_X = wave_sources(i, 1);    % get x, y position of the boat
        centre_Y = wave_sources(i, 2);
        % add new circle to each position, with radius c times greater
        radius = c*(t-i+1);
        viscircles([centre_X centre_Y], radius);    % plot circle
    end
    pause(1)    % wait 1 second before next iteration
end