%% DSP Sandbox install script
% This script will install the entire DSP sandbox to your Matlab path
% including all of the present folders and subfolders. Always run the
% latest verision of install script after you cloned the latest repo to
% your system.

% IMPORTANT: before you run the script navigate your Current Folder to the
% DSP Sandbox repo root, otherwise the installation will be unsuccessful..

addpath(pwd);                     % install the repo root 
addpath(strcat(pwd,'\library'));  % install the library folder

[name, version] = ds_getlibrarydata();

disp(' ');
disp([name, ' ', version, ' successfully installed on your system!']);
clear name version ans

% Created by Tibor Simon at 2014.09.30. Budapest