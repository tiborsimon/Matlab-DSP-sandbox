Matlab-DSP-sandbox
==================

A repo full of useful, DSP related functions and scripts


##Install##

By installing the library, you will put the repository's and it's subfolders path to the global MATLAB path. This allows you to call the functions and scripts defined in this library anywhere in MATLAB.

To install this library you should run the _ds_install.m_ script.

__IMPORTANT__: before you run the script navigate your Current Folder to this repo's root, otherwise the installation will be unsuccessful..

__NOTE__: By installing the library, MATLAB has to save the path to the disk, therefore it needs permission from you to do this for the first time. It will promt a message window if you didn't give the permission yet.

To __check__ the installation, navigate out of the repository's root folder, and type `mylib_dummytest()` If the function prints out a message, you have a correctly installed library on your system.

##Uninstall##

By uninstalling the library, you simply remove the path's added before to the global MATLAB path. This will prevent MATLAB to look for the location of this repository (even if it is deleted) for a function or script name lookup.

To uninstall this library run the _ds_uninstall.m_ script.

It is not necessary to unistall the DSP sandbox from your system. If you delete the repo, nothing will happen. But if you want to keep your Matlab path clean an updated, you should run the uninstall script before you delete the repo.

---

The __master__ branch contains the _Matlab DSP Sandbox_ library, and the __core_template__ branch contains the latest version of the core library management system, that allows anybody to start a fresh Matlab library easily.
