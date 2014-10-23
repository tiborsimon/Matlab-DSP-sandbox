function [ signal ] = ds_cos_tf( lengthInSeconds, frequency, Fs, phase  )
%DS_SIN_TF Cosine wave generation given a fixed length, frequency and sample
%rate.
%
%   Arguments:
%       lengthInSeconds [s]
%       frequency       [Hz]
%       Fs              [Hz]
%       phase           [degree] <optional>

if nargin < 4
    phase = 0;
end
if nargin < 3
    error('Not enough arguments! At least 3 arguments are mandatory!');
end

n = 0:1/Fs:lengthInSeconds;
phase = phase*pi/180;
signal = cos(2*pi*frequency*n + phase);

end

