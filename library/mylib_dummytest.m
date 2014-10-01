function [] = mylib_dummytest()
%MYLIB_DUMMYTEST Function to test the installation of the library.
%   This function does nothing just prints a message to the output window.

[name, version] = core_getlibrarydata();
disp(['Dummy test:: ',name, ' ', version, ' has been set up correctly :)']);

end

