function [f, S] = ds_fft_n_db( signal, fs )
%DS_FFT Summary of this function goes here
%   Detailed explanation goes here

if nargin == 1
    fs = -1;
end

data.fs = fs;
data.MARGIN_TOP = 1.2;
data.MARGIN_BOTTOM = 1.01;
data.interpol = 100;
data.isdB = 1;
data.norm = 1;

[f,S] = ds_fft_core(signal,data);

end

