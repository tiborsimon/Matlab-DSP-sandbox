function [ ret ] = core_checkenvironment( currentFolders )
%CORE_CHECKENVIRONMENT This function makes sure, that you are in
% the right directory.

result = 0;

for k=1:length(currentFolders);
    if strcmp(currentFolders(k).name,'.core_system')
        result = result + 1;
    end
    if strcmp(currentFolders(k).name,'library')
        result = result + 1;
    end
end

ret = result == 2; 

end

