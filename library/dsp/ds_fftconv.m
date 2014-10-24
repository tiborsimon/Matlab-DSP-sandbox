function [ out ] = ds_fftconv( in1, in2 )
%DS_FFTCONV Summary of this function goes here
%   Detailed explanation goes here

in1 = in1(:);
in2 = in2(:);

in1 = ds_zeropad(in1);
in2 = ds_zeropad(in2);

IN1 = fft(in1);
IN2 = fft(in2);

OUT = IN1.*IN2;

out = ifft(OUT);

end

