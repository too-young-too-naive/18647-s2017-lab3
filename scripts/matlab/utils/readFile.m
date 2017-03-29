function [ traces ] = readFile( filename )
%READFILE Opens a .csv file from the visualizer and returns an array of
% structs per trace.

% open file
fd = fopen(filename);

% read device IDs
line = textscan(fd, 'Device ID,%s', 1);
deviceIDs = strsplit(char(line{1}),',');

% read sampling frequencies
line = textscan(fd, 'Sampling Frequency,%s', 1);
sampFreqs = strsplit(char(line{1}),',');

% read clock offsets
line = textscan(fd, 'Clock Offset,%s', 1);
clockOffsets = strsplit(char(line{1}),',');

% read network delays 
line = textscan(fd, 'Network Delay,%s', 1);
delays = strsplit(char(line{1}),',');

% read timestamps 
line = textscan(fd, 'Timestamp,%s', 1);
tstamps = strsplit(char(line{1}),',');

% read lengths
line = textscan(fd, 'Length,%s', 1);
lengths = strsplit(char(line{1}),',');

% close file
fclose(fd);

% how many traces are present
N = length(deviceIDs);

% read the rest as csv data
data = csvread(filename, 7, 1);     %skip 7 rows and 1 column

% combine data as cell array structs
traces = cell(N,1);

for i = 1:N
   trace = struct(...
    'DeviceID', char(deviceIDs(i)),...
    'Fs', str2num(char(sampFreqs(i))),...
    'ClockOffset', str2num(char(clockOffsets(i))),...
    'NetworkDelay', str2num(char(delays(i))),...
    'Timestamp', str2num(char(tstamps(i))),...
    'Length', str2num(char(lengths(i))),...
    'Data', data(:,i) ...
   );
   traces{i} = trace;
end

end

