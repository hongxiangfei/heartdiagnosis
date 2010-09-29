% clear
% Fs=500;
% n=0:1/Fs:0.4;
% w1=200*pi;A1=5;
% w2=400*pi;A2=12;
% xn=A1*(cos(w1*n)+j*sin(w1*n))+A2*(j*sin(w2*n)+cos(w2*n))+randn(size(n));%xn=A1*exp(jw1n)+A2*exp(jw2n);
% subplot(211);
% plot(n,xn);
% xlabel('n');
% ylabel('xn');
% title('xn=A1*exp(jw1n)+A2*exp(jw2n)+e(n)');




ymax_xn=max(xn)+0.2;
ymin_xn=min(xn)-0.2;
axis([0 0.3 ymin_xn ymax_xn]);
p=floor(length(xn)/3)+1;
nfft=1024;
[xpsd,f]=pburg(xn,p,nfft,Fs);
pmax=max(xpsd);
xpsd=xpsd/pmax;
xpsd=10*log10(xpsd+0.000001);
subplot(212);
plot(f,xpsd);
title('Power Spectral estimate with burg');
ylabel('Power Spectral estimate(dB)');
xlabel('w(Hz)');
grid on;
ymin=min(xpsd)-2;
ymax=max(xpsd)+2;
axis([0 Fs/2 ymin ymax]);