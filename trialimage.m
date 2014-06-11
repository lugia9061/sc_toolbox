function m_plotmatrix=trialimage(datasingle,fbands,Nfilt)
%m_plotmatrix=trialimage(datasingle,fbands,Nfilt)
%this file filters the signals and show them in trial*time matrix
%datasingle: format as fieldtrip, has only one channel
%fbands: passband of a bandpass filter
%Nfilt: filter's order
%If the latter two parameters are not inputed, it performs no filtering

if nargin==0
   error('no input')
elseif nargin==1
   flag_filter=0;
elseif nargin>1
   flag_filter=1;
end

if flag_filter
%Use twopass fir filter in fieldtrip for preprocess
cfg=[];
% cfg.channel = dataone.label{chlist_re(channelnum)};
cfg.bpfilter='yes';
cfg.bpfreq=[fbands(1),fbands(2)];
cfg.bpfilttype='fir';

cfg.bpfiltord=Nfilt;   
cfg.bpfiltdir='twopass';
cfg.demean='no';
datasingle = ft_preprocessing(cfg, datasingle);
fs=datasingle.fsample;
end

%Form data matrix
ntrial=numel(datasingle.trial);
alltrial=ntrial;
if isfield(datasingle,'time')
    tm_axis=datasingle.time{1};    %REQUIRE ALL TRIALS HAVE SAME TIME-AXIS
else
    tm_axis=1:length(datasingle.trial{1});
end
m_plotmatrix=zeros(alltrial,length(tm_axis));
for k=1:alltrial
m_plotmatrix(k,:)=datasingle.trial{k};    %REQUIRE ALL TRIALS HAVE SAME TIME-AXIS
end

%Amplitude extraction without padding
Nenvfilt=400;
smoothwin_len=0.2;   %200ms smoothing window
flp=1/smoothwin_len;
benv=fir1(Nenvfilt,flp/fs);
m_plotmatrix=m_plotmatrix.^2;   
m_plotmatrix=transpose(filtfilt(benv,1,transpose(m_plotmatrix)));

figure
clims=[-1,1];   
imagesc(tm_axis,[1:alltrial],m_plotmatrix,clims)
colorbar
