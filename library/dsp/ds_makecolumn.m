function [ out ] = ds_makecolumn( in )
%DS_MAKECOLUMN creates a column vector from a row or a column vector.
s = size(in);
out = in;
if s(2) ~= 1
    out = out';
end
end

