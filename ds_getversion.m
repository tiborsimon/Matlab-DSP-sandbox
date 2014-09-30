function [ version ] = getversion( )
%GETVERSION Returns the current version of the library
%
%   Reads out the version file, and puts it's content into a variable then
%   returns the variable.

fileID = fopen('version','r');
version = fscanf(fileID,'%s');
fclose(fileID);

end

