function [ out ] = ds_fftconv( in1, in2 )
%DS_FFTCONV Summary of this function goes here
%   Detailed explanation goes here

in1 = in1(:);
in2 = in2(:);

N1 = length(in1);
N2 = length(in2);

if N1 >= N2
    N = N1;
else
    N = N2;
end

in1 = ds_zeropad(in1);
in2 = ds_zeropad(in2);

IN1 = fft(in1,N);
IN2 = fft(in2,N);

OUT = IN1.*IN2;

out = ifft(OUT);

end

