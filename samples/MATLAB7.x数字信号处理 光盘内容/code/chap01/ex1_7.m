clear all;
pulse=[1,zeros(1,63)];
b=[0.7 0.3];
a=[1,-0.8,-0.5];
h1=filter(b,a,pulse);
h2=impz(b,a,64);
subplot(2,1,1),stem(h1),title('filter function');
subplot(2,1,2),stem(h2),title('impz function');
