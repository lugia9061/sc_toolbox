%generate a wav of 'beepsound'

fs=44100;
f0=600;
t=0:1/fs:0.1;
w=2*pi*f0;
win=hanning(length(t)).';
x=win.*sin(w*t);
% plot(t,x)
% wavplay(x,fs);
wavwrite(x,fs,'beepsound.wav');