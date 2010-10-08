close all;clear all; clc;
code=[1,1,1,0,0,1,0];
tao=0.5e-6;
fc=10e6;
fs=100e6;
t_tao=0:1/fs:tao-1/fs;
N=length(code);
pha=0;
t=0:1/fs:7*tao-1/fs;
s=zeros(1,length(t));
    for i=1:N
        if code(i)==1
        pha=1;
    else    pha=0;
    end       
       s(1,(i-1)*length(t_tao)+1:i*length(t_tao))=cos(2*pi*fc*t_tao+pha);
    end  
figure,plot(t,s),xlabel('t(单位：秒)'),title('二相码（七位巴克码）');
