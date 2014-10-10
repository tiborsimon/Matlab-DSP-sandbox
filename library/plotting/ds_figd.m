function [ h ] = ds_figd( )
% h = ds_figd()
% opens a docked figure and return it's handle

a = figure() ;
set(a,'windowstyle','docked')

if nargout == 1
    h = a;
end


end

