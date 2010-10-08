clear all
close all
clc
x=ones(1,100);
t=1:100;
b=[0.00183,0.00734,0.1101,0.00737,0.00183];
a=[1,-3.054,3.825,-2.292,0.551];
[b0,B,A]=dir2cas(b,a)
[b,a]=cas2dir(b0,B,A)
y=casfiltr(b0,B,A,x)
y=filter(b,a,x);
plot(t,x,'r',t,y,'k-');
grid on;
ylabel('x(n)”Îy(n)');
xlabel('n');
