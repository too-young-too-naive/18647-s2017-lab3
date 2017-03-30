function plotTraces(traces)
%PLOTTRACES Plot traces parsed from a csv file properly time labeled and
%offset

% number of traces
N = length(traces);

% take the earliest time and re-position all traces relative to t = 0
startTimes = zeros(N,1);
for i = 1:N
   startTimes(i) = traces{i}.Timestamp;
end
% startTimes = startTimes - min(startTimes);

% keep track of trace names
legends = cell(N,1);    

% generate x and y vectors for each trace
figure;
for i = 1:N
    legends{i} = traces{i}.DeviceID;
    
    Fs = traces{i}.Fs;
    
    % generate sample indices
    x = (startTimes(i):(startTimes(i)+traces{i}.Length)-1);
    % convert sample indices to time
    x = x ./ Fs;
    
    % get actual data
    y = traces{i}.Data;
    
    % plot this trace
    plot(x,y);
    
    % plot the next trace on the same figure
    hold on;
end

% add trace legends
legend(legends);
% set x-axis label
xlabel('Time (s)');
% set y-axis label
ylabel('Magnitude');

end

