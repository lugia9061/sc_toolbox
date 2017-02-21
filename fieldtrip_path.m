function fieldtrip_path(x)

if strcmp(x,'add')
    addpath('D:\MATLAB\R2011a\toolbox\fieldtrip-20111018');
    ft_defaults;
elseif strcmp(x,'remove')
    rmpath(genpath('D:\MATLAB\R2011a\toolbox\fieldtrip-20111018'));
else
    return
end

