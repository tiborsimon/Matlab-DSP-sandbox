function [ signal ] = ds_sin_nf( numberOfSamples, frequency, Fs, phase )
%DS_SIN_NF Sine wave generation given a fixed number of samples, frequency 
%and the sample rate.
%
%   Arguments:
%       numberOfSamples [Hz]
%       frequency       []
%       Fs              [Hz]
%       phase           [degree] <optional>

if nargin < 4
    phase = 0;
end
if nargin < 3
    error('Not enough arguments! At least 3 arguments are mandatory!');
end

n = 0:numberOfSamples-1;
n = n*(1/Fs);
phase = phase*pi/180;
signal = sin(2*pi*frequency*n + phase);

end

