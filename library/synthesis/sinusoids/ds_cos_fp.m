function [ signal ] = ds_cos_fp( frequency, numberOfPeriodsOfIt, fs, phase )
%DS_SIN_FP Cosine wave generation given a fixed frequency, number of periods 
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

n = 0:1/fs:(numberOfPeriodsOfIt/frequency);
phase = phase*pi/180;
signal = cos(2*pi*frequency*n + phase);
signal = signal(:);

end



