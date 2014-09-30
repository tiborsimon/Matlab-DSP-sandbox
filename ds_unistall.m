%% DSP Sandbox uninstall script
% This script will install the entire DSP sandbox to your Matlab path
% including all of the present folders and subfolders. Always run the
% latest verision of install script after you cloned the latest repo to
% your system.
% It is not necessary to unistall the DSP sandbox from your system. If you
% delete the repo, nothing will happen. But if you want to keep your Matlab
% path clean an updated, you should run the uninstall script before you
% delete the repo.

% IMPORTANT: before you run the script navigate your Current Folder to the
% DSP Sandbox repo root, otherwise the installation will be unsuccessful..

currentFolders = dir;
result = 0;

for k=1:length(currentFolders);
    if strcmp(currentFolders(k).name,'.core_system')
        result = result + 1;
    end
    if strcmp(currentFolders(k).name,'.git')
        result = result + 1;
    end
end

if result == 2
    [name, version] = ds_getlibrarydata();
    
    rootDirectory = strcat(pwd,'\');
    rmpath(pwd);
    rmpath(strcat(rootDirectory,'.core_system'));
    
    allLibraryDirectories = regexp(genpath('library'),['[^;]*'],'match');
    
    for k=1:length(allLibraryDirectories)
        newPath = strcat(rootDirectory,allLibraryDirectories{k});
        rmpath(newPath);
    end
    
    savepath;
    
    disp(' ');
    disp([name, ' ', version, ' successfully removed from your system!']);
    disp(' ');
    clear name version newPath rootDirectory allLibraryDirectories
else
    error('Error: You are in the wrong folder! Make sure you navigate to the root folder of the repo!');
end

clear ans currentFolders result k

% Created by Tibor Simon at 2014.09.30. Budapest