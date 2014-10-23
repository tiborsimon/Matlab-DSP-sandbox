function [] = ds_fft( signal, fs )
%DS_FFT Summary of this function goes here
%   Detailed explanation goes here

MARGIN_TOP = 1.2;
MARGIN_BOTTOM = 1.2;

N = length(signal);
SIGNAL = fft(signal)/N;
s = abs(SIGNAL);

Nz = N*100;
sz = abs(fft(signal,Nz)/N);


f = (0:N-1)/N*fs;
fz = (0:Nz-1)/Nz*fs;

hold on



plot(fz(1:end/2),sz(1:end/2),'r')
grid
ylim([min(sz)*MARGIN_BOTTOM max(sz)*MARGIN_TOP])

stem(f(1:end/2),s(1:end/2),'fill')
ylim([min(sz)*MARGIN_BOTTOM max(sz)*MARGIN_TOP])







end

