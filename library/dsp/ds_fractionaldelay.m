function y = ds_fractionaldelay(x,n)
%DS_FRACTIONALDELAY Summary of this function goes here
%   Detailed explanation goes here



if n>=length(x)||n<=-length(x)
    y = zeros(length(x),1);
else
    s = size(x);
    
    if s(1) == 1;
        ft = fft(x,2*length(x));
        ft = ft(1:length(ft)/2+1);

        ft = ft.* (exp(-1i*2*pi*n*(0:length(ft)-1)/((2*length(ft)-2))));
        ft = [ft  fliplr(conj(ft(2:end-1)))];
        y = real(ifft(ft));

        y = y(1:length(x));

    else
        
        ft = fft(x,2*length(x));
        ft = ft(1:length(ft)/2+1);

        ft = ft.* (exp(-1i*2*pi*n*(0:length(ft)-1)/((2*length(ft)-2)))).';
        ft = [ft ; flipud(conj(ft(2:end-1)))];
        y = real(ifft(ft));

        y = y(1:length(x));

    end
    
end





