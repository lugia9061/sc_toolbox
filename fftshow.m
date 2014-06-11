function fftshow(y,fs)
%fftshow(y,fs) 
%shows Single-Sided Amplitude Spectrum of a signal

NFFT=2048;L=length(y);
Y = fft(y,NFFT)/L;
Y = 2*abs(Y(1:NFFT/2+1));
Y = 10*log10(Y+eps);
f = fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(f,Y) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('10*log10|Y(f)|')