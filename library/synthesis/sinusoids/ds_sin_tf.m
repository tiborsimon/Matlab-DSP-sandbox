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


frequency = frequency(:);
s = size(frequency);


n = 0:1/fs:lengthInSeconds-1/fs;
phase = phase*pi/180;
signal = sin(2*pi*frequency(1)*n + phase);
if s(1) > 1 
    for k=2:s(1)
        signal = signal + sin(2*pi*frequency(k)*n + phase);
    end    
end


signal = signal(:);
signal = signal./max(signal);



end

