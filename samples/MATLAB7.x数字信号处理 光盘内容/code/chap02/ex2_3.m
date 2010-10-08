clear all
close all
clc
n=0:8;
x=[1,2,3,4,5,6,7,8,9];
y2=cirshftt(x,2,9);
y4=cirshftt(x,4,9);
y6=cirshftt(x,6,9);
y8=cirshftt(x,8,9);
y9=cirshftt(x,9,9);
subplot(611)
stem(n,x);
ylabel('x(n)')
subplot(612)
stem(n,y2);
ylabel('y2)')
subplot(613)
stem(n,y4);
ylabel('y4(n)')
subplot(614)
stem(n,y6);
ylabel('y6(n)')
subplot(615)
stem(n,y8);
ylabel('y8(n)')
subplot(616)
stem(n,y9);
ylabel('y9(n)')

