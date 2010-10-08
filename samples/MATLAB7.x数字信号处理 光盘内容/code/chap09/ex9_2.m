close all;
clear all;
clc;
t=10e-6;
fs=100e6;
fc=10e6;
B=2e6;
ft=0:1/fs:t-1/fs;
N=length(ft);
k=B/fs*2*pi/max(ft);
y=modulate(ft,fc,fs,'fm',k);
y_fft_result=fft(y);
figure,subplot(2,1,1),plot(ft,y),xlabel('t(单位：秒)'),
ylabel('y(单位：伏)'),title('线性调频信号y(t)');
subplot(2,1,2),plot((0:fs/N:fs/2-fs/N),abs(y_fft_result(1:N/2))),
xlabel('频率f(单位:Hz)'),title('线性调频信号y(t)的频谱');
