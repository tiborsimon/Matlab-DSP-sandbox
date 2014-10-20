function [ out ] = ds_makerow( in )
%DS_MAKEROW creates a row vector from a row or a column vector.
s = size(in);
out = in;
if s(1) ~= 1
    out = out';
end

end

