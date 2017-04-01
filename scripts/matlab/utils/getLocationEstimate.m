function [ estimate ] = getLocationEstimate(traces, sensorLocations, velocity)
%GETLOCATIONESTIMATE Calculates an estimated location based on the time
%differences of arrival between an array of traces and associated sensor
%locations.

assert(length(traces) == length(sensorLocations), 'Number of traces should equal number of sensors');
assert(velocity > 0, 'Speed of sound must be positive');

N = length(sensorLocations);
Ndimen = N-1;

% first sensor is always the reference
sRef = sensorLocations(1,:);
tRef = traces{1};

% get TDoA for each sensor
tdoa = zeros(Ndimen,1);
for index = 1:Ndimen
   tdoa(index) = getCorrelationTimeLag(traces{index+1}, tRef); 
end

% get centroid of sensor area
minBounds = min(sensorLocations);
maxBounds = max(sensorLocations);
x0 = (maxBounds + minBounds)/2;

options = optimoptions('fsolve', 'Algorithm', 'levenberg-marquardt', 'Display', 'none');

[estimate, ~, exitflag] = fsolve(@(x)buildEquations(x, sensorLocations, tdoa, velocity), x0, options);

end

function F = buildEquations(target, sensors, tdoas, velocity)

N = length(tdoas);

% reference sensor/position
p0 = sensors(1,:);

F = zeros(N,1);
for i = 1:N
    % see https://en.wikipedia.org/wiki/Multilateration#Measuring_the_time_difference_in_a_TDOA_system
    F(i) = (norm(target - sensors(i+1,:)) - norm(target - p0) - velocity*tdoas(i));
end

end