%example1_1
%unit sample sequence
clear all;
N=32;
x=zero(1,N);
x(1)=1;
xn=0:N-1;
stem(xn,x)
axis([-1 33 0 1.1])
