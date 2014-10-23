function [ signal ] = ds_sin_tf( lengthInSeconds, frequency, fs, phase  )
%DS_SIN_TF Sine wave generation given a fixed length, frequency and sample
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

n = 0:1/fs:lengthInSeconds-1/fs;
phase = phase*pi/180;
signal = sin(2*pi*frequency*n + phase);
signal = signal(:);

end

