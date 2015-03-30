function [ l ] = ij2l( i, j, n )
%IJ2L Upper Triangle Matrix Coordinates to Single Row Index
    l = j;
    for k=1:(i-1)
        l = l + (n-k);
    end
end

