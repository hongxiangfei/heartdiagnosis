clear  all;
close  all;
clc;
t=100e-6;
fs=40e6;
fc=9e6;
f0=10e6;
B=2e6;
ft=0:1/fs:t-1/fs;
N=length(ft);
k=B/fs*2*pi/max(ft);
y=modulate(ft,fc,fs,'fm',k);
y_fft_result=fft(y);
figure,
subplot(2,1,1),plot(ft,y),xlabel('t����λ���룩'),ylabel('y����λ������'),title('���Ե�Ƶ�ź�y(t)');
subplot(2,1,2),plot((0:fs/N:fs/2-fs/N),abs(y_fft_result(1:N/2))),
xlabel('Ƶ��f����λ��Hz��'),title('���Ե�Ƶ�ź�y(Ƶ��');
%%%%%%%%%%%%%%%%%�������%%%%%%%%%%%%%
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);
local_oscillator_q=sin(n*f0/fs*2*pi);
fbb_i=local_oscillator_i.*y;
fbb_q=local_oscillator_q.*y;
window=chebwin(51,40);
[b,a]=fir1(50,2*B/fs,window);
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);

figure,
subplot(2,1,1),plot(ft,fbb_i),xlabel('t����λ���룩'),title('�����I·�ź�');
subplot(2,1,2),plot(fbb_q),
xlabel('t����λ���룩'),title('�����I·�ź�');
fbb=fbb_i+j*fbb_q;
fbb_fft_result=fft(fbb);
figure,
plot((0:fs/N:fs/2-fs/N),abs(fbb_fft_result(1:N/2))),
xlabel('Ƶ��f����λ��Hz��'),title('������źŵ�Ƶ��');
