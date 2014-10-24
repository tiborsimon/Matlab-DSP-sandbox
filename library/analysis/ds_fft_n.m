function [] = ds_fft_n( signal, fs )
%DS_FFT Summary of this function goes here
%   Detailed explanation goes here

if nargin == 1
    fs = -1;
end

data.fs = fs;
data.MARGIN_TOP = 1.2;
data.MARGIN_BOTTOM = 1.2;
data.interpol = 100;
data.isdB = 0;
data.norm = 1;

ds_fft_core(signal,data);

end

