clear all;
close all;
clc;
b=[4,-5,6,-7];
a=[1 -2 3];
x0=[1 -1];
y0=[-1 1];
xic=filtic(b,a,y0,x0)
bxplus=1;
axplus=[1 -1];
ayplus=conv(a,axplus)
byplus=conv(b,bxplus)+conv(xic,axplus)
[R,P,K]=residuez(byplus,ayplus)
Mp=abs(P)
Ap=angle(P)*180/pi
N=100;
n=0:N-1;
xn=ones(1,N);
yn=filter(b,a,xn,xic);
plot(n,yn)
