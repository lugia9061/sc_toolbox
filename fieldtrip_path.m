function fieldtrip_path(x)

if strcmp(x,'add')
    addpath(genpath('G:\MATLAB\R2011a\toolbox\fieldtrip-20111018'));
%     ft_defaults;
elseif strcmp(x,'remove')
    rmpath(genpath('G:\MATLAB\R2011a\toolbox\fieldtrip-20111018'));
else
    return
end

