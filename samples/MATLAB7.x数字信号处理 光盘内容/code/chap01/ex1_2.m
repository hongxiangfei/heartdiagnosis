%example1-2
%unit sample sequence
clear all;
N=32;
K=20;
x=zero(1,N);
x(k)=1;
xn=0:N-1;
stem(xn,x)
axis([-1 33 0 1.1])
