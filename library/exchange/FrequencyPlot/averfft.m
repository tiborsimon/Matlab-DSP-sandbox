function [Px,freq]=averfft(sig,Noct,Nfft)

% sig is mono or stereo time data (column) vector
% Noct is 1/Noct octave smooth resolution (default=0 => no smooth);
% Nfft igs FFT length (default=8192)
% if no output specified averfft plots frequency data;

if size(sig,2)>size(sig,1)
    sig=sig';
end
if nargin < 2
    Noct=0;
end
if nargin < 3
    Nfft=8192;
end
% parameter definition
L=length(sig);
if L > Nfft
    Lwin=Nfft/2; % window length == length of segment
    ovrlp =Nfft/4; % 50% overlap 
    Nseg=(L-ovrlp)/(Lwin-ovrlp);
    win=0.5*(1-cos(2*pi*(1:Lwin)'/(Lwin+1))); % hanning window
    for i=1:size(sig,2)/2
        win=[win win];
    end
    n1=1;
    Px=0;
    % average fft
    for i=1:Nseg
        n2=n1+Lwin-1;
        N=n2-n1+1;
        a=norm(win)^2/N;
        xw=sig(n1:n2,:).*win;
        Px_i=abs(fft(xw,Nfft)).^2/(N*a);
        Px=Px+Px_i/Nseg;
        n1=n1+ovrlp;
    end;
    Px=10*log10(Px(1:end/2,:));
else
    Px=20*log10(abs(fft(sig,Nfft)));
    Px=Px(1:end/2,:);
end
freq=(0:44100/(Nfft-1):22050)';

%--------------------------------------------------------------------------
% octave smoothing
if Noct > 0
    Noct=2*Noct;
    % octave center frequencies
    f1=1;
    i=0;
    while f1 < 22050
        f1=f1*10^(3/(10*Noct));
        i=i+1;
        fc(i,:)=f1;
    end

    % octave edge frequencies
    for i=0:length(fc)-1
        i=i+1;
        f1=10^(3/(20*Noct))*fc(i);
        fe(i,:)=f1;
    end

    % find nearest frequency edges
    for i=1:length(fe)
        fe_p=find(freq>fe(i),1,'first');
        fe_m=find(freq<fe(i),1,'last');
        fe_0=find(freq==fe(i));
        if isempty(fe_0)==0
            fe(i)=fe_0;
        else
            p=fe_p-fe(i);
            m=fe(i)-fe_m;
            if p<m
                fe(i)=fe_p;
            else
               fe(i)=fe_m;
            end
        end
    end
assignin('base','a',fe);
    for i=1:length(fe)-1
        Px_i=Px(fe(i):fe(i+1),:);
        Px_oct(i,1:size(Px,2))=mean(Px_i);
    end
    fc=fc(2:end);
    Px_oct=interp1(fc,Px_oct,freq,'spline');
end


%--------------------------------------------------------------------------
if nargout == 0
    figure1 = figure('PaperPosition',[0.6345 6.345 20.3 15.23],'PaperSize',[20.98 29.68]); 
    axes(...
      'FontWeight','bold',...
      'XGrid','on','XScale','log',...
      'XMinorGrid','on',...
      'XTick',[16,22,32,45,63,89,126,178,251,355,501,708,1000,1413,1995,2818,3981,5623,7943,11220,15849],...
      'XTickLabel',{'16','22','32','45','63','90','125','180','250','350','500','700','1k','1.4k','2k','2.8','4k','5.6k','8k','11.2k','16k'},...
      'YGrid','on',...
      'Parent',figure1);
    xlim([22 1.6e+004]);
    box('on');
    hold('all'); 
    plot(freq,Px,'LineWidth',1,'Color',[0 0 1],'DisplayName',[num2str(Nfft) '-point FFT']);
    if Noct > 0
        plot(freq,Px_oct,'LineWidth',2,'Color',[1 0 0],'DisplayName',['1/' num2str(Noct/2) '-oct. smooth']);
    end
    xlabel('frequency / Hz','FontWeight','bold');
    ylabel('amplitude / dB','FontWeight','bold');
end
%--------------------------------------------------------------------------
if Noct > 0
    Px=Px_oct;
end