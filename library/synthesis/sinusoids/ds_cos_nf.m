function [ signal ] = ds_cos_nf( numberOfSamples, frequency, fs, phase )
%DS_SIN_NF Cosine wave generation given a fixed number of samples, frequency 
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
n = n*(1/fs);
phase = phase*pi/180;
signal = cos(2*pi*frequency*n + phase);
signal = signal(:);

end



