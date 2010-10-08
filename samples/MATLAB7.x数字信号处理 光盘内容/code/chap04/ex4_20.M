%use zero pole methed to design highpass DF
clear all;
syms rad z hz hrad angle;
Wh=0.8*pi;
a=cos(Wh)/(1+sin(Wh));
hz=(2/(1-a)*((1-1/z)/(1+a/z)));
hrad=subs(hz,exp(i*rad));
subplot(211);
ezplot(abs(hrad));
title('幅度特性曲线')
grid on;
subplot(212);
angle=atan(imag(hrad)/real(hrad));
ezplot(angle);
title('相位特性曲线')
grid on;
