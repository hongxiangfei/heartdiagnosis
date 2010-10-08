clear all;
close all;
clc;
N=32;
n=0:N-1;
xn=cos(pi*n/6);
k=0:N-1;
WN=exp(-j*2*pi/N);
nk=n'*k;
WNnk=WN.^nk;
Xk=xn*WNnk;
figure(1)
stem(n,xn)
figure(2)
stem(k,abs(Xk));
