%% DSP Sandbox install script
% This script will install the entire DSP sandbox to your Matlab path
% including all of the present folders and subfolders. Always run the
% latest verision of install script after you cloned the latest repo to
% your system.

% IMPORTANT: before you run the script navigate your Current Folder to the
% DSP Sandbox repo root, otherwise the installation will be unsuccessful..

currentFolders = dir;
result = 0;

for k=1:length(currentFolders)
    if strcmp(currentFolders(k).name,'.core_system')
        result = result + 1;
    end
    if strcmp(currentFolders(k).name,'.git')
        result = result + 1;
    end
end

if result == 2 
    rootDirectory = strcat(pwd,'\');
    addpath(pwd);
    addpath(strcat(rootDirectory,'.core_system'));
    
    allLibraryDirectories = regexp(genpath('library'),['[^;]*'],'match');
    
    for k=1:length(allLibraryDirectories)
        newPath = strcat(rootDirectory,allLibraryDirectories{k});
        addpath(newPath);
    end

    savepath;

    [name, version] = ds_getlibrarydata();

    disp(' ');
    disp([name, ' ', version, ' successfully installed on your system!']);
    disp(' ');
    clear name version newPath rootDirectory allLibraryDirectories
else
    error('Error: You are in the wrong folder! Make sure you navigate to the root folder of the repo!');
end

clear ans currentFolders result k




% Created by Tibor Simon at 2014.09.30. Budapest