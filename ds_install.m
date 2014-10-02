%% DSP Sandbox install script
% This script will install the entire DSP sandbox to your Matlab path
% including all of the present folders and subfolders. Always run the
% latest verision of install script after you cloned the latest repo to
% your system.

% IMPORTANT: before you run the script navigate your Current Folder to the
% DSP Sandbox repo root, otherwise the installation will be unsuccessful..

%% Test the current location

rootDirectory = strcat(pwd,'\');

try
    addpath(pwd);
    addpath(strcat(rootDirectory,'.core_system'));
    check = core_checkenvironment(dir); 
catch err 
    check = 0;
    rmpath(pwd);
    rmpath(strcat(rootDirectory,'.core_system'));
end

%% Based on the previous test, add the libraries or send an error message

if check
    allLibraryDirectories = regexp(genpath('library'),['[^;]*'],'match');
    
    for k=1:length(allLibraryDirectories)
        newPath = strcat(rootDirectory,allLibraryDirectories{k});
        addpath(newPath);
    end

    savepath;

    [name, version] = core_getlibrarydata();

    disp(' ');
    disp([name, ' ', version, ' successfully installed on your system!']);
    disp(' ');
    clear name version newPath rootDirectory allLibraryDirectories
else
    clear check err rootDirectory
    error('Error: You are in the wrong folder! Make sure you navigate to the root folder of your library that contains the install script!');
end

clear ans currentFolders result k check

% Created by Tibor Simon at 2014.10.02. Budapest