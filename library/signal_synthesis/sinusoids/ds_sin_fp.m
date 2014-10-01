function [ signal ] = ds_sin_fp( frequency, numberOfPeriodsOfIt, Fs, phase )
%DS_SIN_FP Sine wave generation given a fixed frequency, number of periods 
%of it and the sample rate.
%
%   Arguments:
%       frequency           [Hz]
%       numberOfPeriodsOfIt []
%       Fs                  [Hz]
%       phase               [degree] <optional>

if nargin < 4
    phase = 0;
end
if nargin < 3
    error('Not enough arguments! At least 3 arguments are mandatory!');
end

n = 0:1/Fs:(numberOfPeriodsOfIt/frequency);
phase = phase*pi/180;
signal = sin(2*pi*frequency*n + phase);

end

