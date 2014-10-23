function [] = ds_fft( signal, fs )
%DS_FFT Summary of this function goes here
%   Detailed explanation goes here

s = size(signal);
count = s(2);

if s(1) < s(2)
    signal = signal';
    count = s(1);
end

MARGIN_TOP = 1.2;
MARGIN_BOTTOM = 1.2;

N = length(signal(:,1));
S = abs(fft(signal));
S = S(1:floor(end/2),:);

N_int = N*100;
S_int = abs(fft(signal,N_int));
S_int = S_int(1:floor(end/2),:);

f = (0:N/2-1)./(N/2);
f_int = (0:N_int/2-1)./(N_int/2);
    
if nargin == 1
    xlimup = 1;
    xlab = 'Normalized frequency';
else
    f = f.*(fs/2);
    f_int = f_int.*(fs/2);
    xlimup = fs/2;
    xlab = 'Frequency [Hz]';
end

figure

plot(f_int,S_int,'r')
hold on
stem(f,S,'fill')

grid on
ylim([min(min(S_int))*MARGIN_BOTTOM max(max(S_int))*MARGIN_TOP])
xlim([0 xlimup]);
title('Precise spectrum');
ylabel('Amplitude');
xlabel(xlab);
% legend('Interpolated spectrum','Spectrum')

end

