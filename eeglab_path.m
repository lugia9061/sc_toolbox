function eeglab_path(x)

if strcmp(x,'add')
    addpath(genpath('D:\MATLAB\R2011a\toolbox\eeglab8'));
elseif strcmp(x,'remove')
    rmpath(genpath('D:\MATLAB\R2011a\toolbox\eeglab8'));
else
    return
end