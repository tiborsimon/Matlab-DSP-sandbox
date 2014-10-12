function outputVector = ds_zeropad( inputVector, numberOfZeros )
% outputVector = ds_zeropad( inputVector, numberOfZeros )
%
% Appends the given number of zeros to the given vector.. If 
% the length isn't specified, ds_zeropad uses the length of the
% given vector.

if nargin == 1
    numberOfZeros = length(inputVector);
end

s = size(inputVector);

if s(1) == 1;
    outputVector = [inputVector zeros(1,numberOfZeros)];
else
    outputVector = [inputVector; zeros(numberOfZeros,1)];
end
end

