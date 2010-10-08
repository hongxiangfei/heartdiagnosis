Fs=2000;
NFFT=1024;
n=0:1/Fs:1;
x=sin(2*pi*100*n)+4*sin(2*pi*500*n)+randn(size(n)); % 噪声序列
X=fft(x,NFFT);            % 计算FFT
pxx=abs(X).^2/length(n);  % 求解PSD
t=0:round(NFFT/2-1);
k=t*Fs/NFFT;
P=10*log(pxx(t+1));    % 纵坐标的单位为dB
plot(k,P);
