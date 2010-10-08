Fs=2000;
NFFT=1024;
n=0:1/Fs:1;
x=sin(2*pi*100*n)+4*sin(2*pi*500*n)+randn(size(n)); % дыЩљађСа
window=boxcar(length(x));
periodogram(x,window,NFFT,Fs);
