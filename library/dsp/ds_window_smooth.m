function [ y ] = ds_window_smooth( x, frontWindowLength, backWindowLength )
%DS_WINDOW_SMOOTH Summary of this function goes here
%   Detailed explanation goes here

if nargin == 2
    backWindowLength = frontWindowLength;
end

x = x(:);

Nf = frontWindowLength;
Nb = backWindowLength;

wf = hann(Nf*2);
wf = wf(1:Nf);
wf = wf.*wf;

wb = hann(Nb*2);
wb = wb(Nb+1:end);
wb = wb.*wb;

x(1:Nf) = x(1:Nf).*wf;
x(end-Nb+1:end) = x(end-Nb+1:end).*wb;

y = x;

end

