%example1-3
%unit step sequence
clear all;
N=32;
x=ones(1,N);
xn=0:N-1;
stem(xn,x);
axis([-1 32 0 1.1]);
