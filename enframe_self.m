function [wavframes,t]=enframe_self(wavfile,framelen,frameshift,winname)
%segment wavfile into frames, one per row
%INPUT:
%wavfile: wave file, col vector
%framelen: length of a frame
%frameshift: step of frames
%winname: type of window
%OUTPUT:
%wavframes: segmented frames, one per row, numframe*framelen matrix
%t: time center of every frame.

win=window(winname,framelen).';
numframe=fix((length(wavfile)-framelen)/frameshift)+1;   %set aside the last one frame
nd=length(wavfile)-(numframe-1)*frameshift-framelen;

t=framelen/2:frameshift:framelen/2+(numframe-1)*frameshift;

wavframes=zeros(numframe,framelen);
findx=frameshift*(0:(numframe-1)).';
sindx=1:framelen;

wavframes(:)=wavfile(findx(:,ones(1,framelen))+sindx(ones(numframe,1),:));  %generate wavframes

wavframes(numframe+1,1:nd)=wavfile(1+length(wavfile)-nd:end);  %zero padding for the last frame
wavframes=wavframes.*win(ones(numframe+1,1),:);

t(end+1)=numframe*frameshift+framelen/2;
numframe=size(wavframes,1);   %actual frame number

