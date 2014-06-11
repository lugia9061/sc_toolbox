function [peak_val,peak_indx]=peak_delay(data,seg_winlen,varargin)
%This funciton gives the peak delay of every trial
%The single trial signal is firstly cut into small blocks, 
%After finding the max energy in the blocks, the function returns the position of the peak in this block
%relative to the start of trial (in #points)
%INPUT:
%data : mTrials * nSamples
%seg_winlen :#points of quick finding window
%mode: 'negative' -- find the negative peak  
%
%OUTPUT:
%peak_indx : indx of the peaks in these trials, nTrials*1
%peak_val : value of the peaks, nTrials*1

%Written by Chen Song, 20130829

%DEBUG---------------
% y=linspace(1,20,1200);
% y=[y;circshift(y,[0,60]);-circshift(y,[0,120])];
% data=y; fs=1200; winlen=360;
% seg_winlen=0.05*fs;
%--------------------
if varargin{1}=='negative'
    data=-data;
end

[nTrials,nSamples]=size(data);
winlen=nSamples;
tmp=zeros(nTrials,ceil(winlen/seg_winlen));
for i=1:size(tmp,2)
tmp(:,i)=sum(data(:,((i-1)*seg_winlen+1):i*seg_winlen),2);
end
[tmp2,maxindx]=max(tmp,[],2);
peak_indx=zeros(nTrials,1);
peak_val=zeros(nTrials,1);
for i=1:size(data,1)
    j=maxindx(i);
    [peak_val(i),peak_indx(i)]=max(data(i,((j-1)*seg_winlen+1):j*seg_winlen));
    peak_indx(i)=peak_indx(i)+(j-1)*seg_winlen;
end

if varargin{1}=='negative'
    peak_val=-peak_val;
end
