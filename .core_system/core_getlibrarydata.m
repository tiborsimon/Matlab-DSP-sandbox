function [ name, version ] = core_getlibrarydata()
%CORE_GETLIBRARYDATA Returns the current version of the library
%
%   Reads out the version file, and puts it's content into a variable then
%   returns the variable.

fileID = fopen('librarydata');
name = fgetl(fileID);
version = fgetl(fileID);
fclose(fileID);

end

