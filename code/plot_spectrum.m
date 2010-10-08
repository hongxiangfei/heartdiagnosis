function plot_spectrum(x,fs,mf) 
if nargin<3
    mf=fs/2;
end
N=length(x);
%消除直流分量
x=x-mean(x);
%修正N(偶数)
N=floor(N/2)*2;
y=fft(x,N);
mag=abs(y)*2/N;
%mag=[mag(1)/2; mag(2:end)];
f=(0:length(y)-1)'*fs/length(y);
stop = floor(N/fs*mf);
plot(f(1:stop),mag(1:stop));
xlabel('频率(Hz)');
ylabel('幅值');
title('心音信号 幅频谱图');
grid;