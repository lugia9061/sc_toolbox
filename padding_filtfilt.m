function y=padding_filtfilt(b,a,x)
%y=padding_filtfilt(b,a,x)
%filtfilt with mirror padding
%Designed for only FIR filters now

%INPUT:
% x :a col vector or matrix with data along columns
%[b,a]: filter

%OUTPUT
%y : a col vector or matrix with data along columns, filtered signals

numpad=3*length(b);

%zero padding (deleted)
% p=size(x,2);
% tmp=[zeros(numpad,p);x;zeros(numpad,p)];

tmp=[flipud(x((2:numpad),:));x;flipud(x((end-numpad+1:end),:))];   %symmetric padding is better than zero padding
%But this can also cause oscillations near the starting and ending point of
%padding, this cannot be cancelled (due to signal is not truely symmetric)
tmp2=filtfilt(b,a,tmp);
y=tmp2(numpad:(end-numpad),:);
