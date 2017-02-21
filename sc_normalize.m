function Y=sc_normalize(X)
%This function normalize every column of X by (X-mean)/std

[nRow,nCol]=size(X);
Y=(X-repmat(mean(X),nRow,1))./(repmat(std(X),nRow,1));
end