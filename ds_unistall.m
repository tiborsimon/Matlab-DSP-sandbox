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

rmpath(pwd);                     % install the repo root 
rmpath(strcat(pwd,'\library'));  % install the library folder

[name, version] = ds_getlibrarydata();

disp(' ');
disp([name, ' ', version, ' successfully removed from your system!']);
clear name version ans

% Created by Tibor Simon at 2014.09.30. Budapest