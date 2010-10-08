clear all;
clc;
close all;
fs=1000;
pulse=[1,zeros(1,63)];
b=[0.3 0.2];
a=[1,-0.4,-0.7];
[h,f]=freqz(b,a,256,fs);
mag=abs(h);
ph=angle(h);
ph=ph*180/pi;
subplot(2,1,1),plot(f,mag),
grid,xlabel('freqency(Hz)'),ylabel('magnitude');
subplot(2,1,2),plot(f,ph),grid,xlabel('freqency(Hz)'),ylabel('phase');
