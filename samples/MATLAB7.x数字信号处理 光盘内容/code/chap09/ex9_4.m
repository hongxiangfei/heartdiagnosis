close all;clear all;clc;
code=[1,1,1,0,1,0,1];%7位巴克码
tao=10e-6;%脉冲宽度10us
fc=0.5e6;%调频信号起始频率
fs=10e6;%采样频率l00MHz
B=1e6;%调频信号带宽
t_tao=0:1/fs:tao-1/fs;
N=length(t_tao);
k=B/fs*2*pi/max(t_tao);
n=length(code);
pha=0;
s=zeros(1,n*N);
for i=1:n
        if code(i)==1
        pha=pi;
    else    pha=0;
    end       
       s(1,(i-1)*N+1:i*N)=cos(2*pi*fc*t_tao+k*cumsum(t_tao)+pha);
    end  
t=0:1/fs:7*tao-1/fs;
figure,subplot(2,1,1),plot(t,s),xlabel('t(单位：秒)'),
title('混合调制信号（7位巴克码＋线性调频');
s_fft_result=abs(fft(s(1:N)));
subplot(2,1,2),plot((0:fs/N:fs/2-fs/N),abs(s_fft_result(1:N/2))),
xlabel('频率f(单位:Hz)'),title('码内信号频谱');
