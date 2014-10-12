function [ out ] = ds_fft_norm( signal, fftCount )
%DS_FFT_NORM Summary of this function goes here
%   Detailed explanation goes here

N = length(signal);
if nargin == 1
    fftCount = N;
end

out = fft(signal,fftCount)./N;


end

