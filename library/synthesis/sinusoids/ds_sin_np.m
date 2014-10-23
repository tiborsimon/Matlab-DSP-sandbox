function [ signal ] = ds_sin_np( numberOfSamples, numberOfPeriodsInIt, phase )
%DS_SIN_NP Sine wave generation given a fixed number of samplesand the number of 
%periods in it.
%
%   Arguments:
%       numberOfSamples     [Hz]
%       numberOfPeriodsInIt []
%       phase               [degree] <optional>

if nargin < 3
    phase = 0;
end
if nargin < 2
    error('Not enough arguments! At least 2 arguments are mandatory!');
end

n = 0:numberOfSamples-1;
n = n'/numberOfSamples;
phase = phase*pi/180;
signal = sin(2*pi*numberOfPeriodsInIt*n + phase);
signal = signal(:);

end

