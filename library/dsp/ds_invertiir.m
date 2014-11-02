function [ bi,ai ] = ds_invertiir( b,a )
%DS_INVERTIIR Summary of this function goes here
%   Detailed explanation goes here
bi = a;
% if the original filter isn't minimal phase, has zeros
% outside the unit circle, the inverse filter will be 
% unstable..

zeroRoots = roots(b);
[theta,r] = cart2pol(real(zeroRoots),imag(zeroRoots));
for k = 1:length(zeroRoots)
   if r(k) > 1
       r(k) = 1/r(k);
   end
end
[x,y] = pol2cart(theta,r);
newRoots = x+1i.*y;
ai = poly(newRoots);

end

