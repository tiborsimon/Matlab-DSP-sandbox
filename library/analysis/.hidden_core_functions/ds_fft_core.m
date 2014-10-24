function [] = ds_fft_core( signal, data )
%DS_FFT_CORE Summary of this function goes here
%   Detailed explanation goes here
s = size(signal);
count = s(2);

if s(1) < s(2)
    signal = signal';
    count = s(1);
end

MARGIN_TOP = data.MARGIN_TOP;
MARGIN_BOTTOM = data.MARGIN_BOTTOM;

N = length(signal(:,1));
S = abs(fft(signal));
S = S(1:floor(end/2),:);

N_int = N*100;
S_int = abs(fft(signal,N_int));
S_int = S_int(1:floor(end/2),:);

if data.norm > 0
    S = S./N;
    S_int = S_int./N;
end

if data.isdB == 1
    S = db(S);
    S_int = db(S_int);
    if max(max(S_int))<0
        MARGIN_TOP = 0;
    end
end

f = (0:N/2-1)./(N/2);
f_int = (0:N_int/2-1)./(N_int/2);
    
if data.fs < 0
    xlimup = 1;
    xlab = 'Normalized frequency';
else
    f = f.*(data.fs/2);
    f_int = f_int.*(data.fs/2);
    xlimup = data.fs/2;
    xlab = 'Frequency [Hz]';
end

figure

grayBase =.75;
plot(f_int,S_int,'Color',[grayBase,grayBase,grayBase])
hold on

if data.isdB == 1
    legendHandle = plot(f,S,'.-','markersize',20);
else
    legendHandle = stem(f,S,'fill');
end

grid on
ylim([min(min(S_int))*MARGIN_BOTTOM max(max(S_int))*MARGIN_TOP])
xlim([0 xlimup]);

if data.norm > 0
    title('Precise Normalized Spectrum');
else
    title('Precise Spectrum');
end


if data.isdB == 1
    ylabel('Magnitude [dB]');
else
    ylabel('Amplitude');
end
xlabel(xlab);

% for k=1:count
%    M{1} = sprintf('Signal %d',k); 
% end
% legend(legendHandle,M)

end

