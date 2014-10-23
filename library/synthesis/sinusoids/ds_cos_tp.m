function [ signal ] = ds_cos_tp( lengthInSeconds, numberOfPeriods, Fs, phase )
%DS_SIN_TP Cosine wave generation given a fixed length in seconds, number of periods 
%of it and the sample rate.
%
%   Arguments:
%       frequency       [Hz]
%       numberOfPeriods []
%       Fs              [Hz]
%       phase           [degree] <optional>

if nargin < 4
    phase = 0;
end
if nargin < 3
    error('Not enough arguments! At least 3 arguments are mandatory!');
end

n = 0:1/Fs:lengthInSeconds;
n=n/lengthInSeconds;
phase = phase*pi/180;
signal = cos(2*pi*numberOfPeriods*n + phase);

end

