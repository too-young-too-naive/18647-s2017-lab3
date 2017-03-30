function [ timeLag ] = getCorrelationTimeLag( trace1, trace2 )
%GETCORRELATIONTIMELAG Returns the time lag between two traces by
%performing a cross-corellation between them. If not output args are given,
%this function will plot the traces and resulting correlation

assert(trace1.Fs == trace2.Fs, 'Sampling frequency between traces must be equal');

Fs = trace1.Fs;
offset = (trace1.Timestamp - trace2.Timestamp);

% get traces
y1 = trace1.Data;
y2 = trace2.Data;

% remove DC components
y1 = y1 - mean(y1);
y2 = y2 - mean(y2);

% correlate the two traces
[acor,lag] = xcorr(y1,y2);

% by how many samples are they off
[~,I] = max(abs(acor));
lagDiff = lag(I);           

% offset by timestamp differences
lagDiff = lagDiff + offset;

% convert to actual time differece
timeLag = lagDiff / Fs;

% if user didn't provide an output var, plot the traces
if nargout ==0
    figure;
    
    % get data
    x1 = (trace1.Timestamp:(trace1.Timestamp+trace1.Length)-1);
    x1 = x1 ./ Fs;
    
    x2 = (trace2.Timestamp:(trace2.Timestamp+trace2.Length)-1);
    x2 = x2 ./ Fs;
    
    minX = min([x1 x2]);
    maxX = max([x1 x2]);
    minY = min(min([y1,y2]));
    maxY = max(max([y1,y2]));
    
    minX_aligned = min([x1 (x2+timeLag)]);
    maxX_aligned = max([x1 (x2+timeLag)]);
    
    % plot traces
    subplot(3,1,1);
    plot(x1,y1,x2,y2);
    title('Original Traces')
    xlabel('Time (s)');
    ylabel('Magnitude');
    axis([minX maxX minY maxY]);
    legend(trace1.DeviceID, trace2.DeviceID);
    
    % plot the correlation
    subplot(3,1,2);
    plot(((lag + offset) ./Fs),acor);
    title(['Time Lag = ', num2str(timeLag), 's']);
    xlabel('Time (s)');
    ylabel('Correlation');
    axis tight;
    
    % plot the aligned traces
    subplot(3,1,3);
    plot(x1,y1,(x2 + timeLag),y2);
    title('Aligned Traces')
    xlabel('Time (s)');
    ylabel('Magnitude');
    axis([minX_aligned maxX_aligned minY maxY]);
    legend(trace1.DeviceID, trace2.DeviceID);
    
end

end

