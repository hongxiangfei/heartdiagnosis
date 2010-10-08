clear all
close all
clc
M=32;
alpha=(M-1)/2;
magHk=[1,1,1,0.5,zeros(1,25),0.5,1,1];
k1=0:15;
k2=16:M-1;
angHk=[-alpha*2*pi/M*k1,alpha*2*pi/M*(M-k2)];
H=magHk.*exp(j*angHk);
h=real(ifft(H,M));
[C,B,A]=dir2fs(h)
