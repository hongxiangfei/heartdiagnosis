function plot_spectrum(x,fs,mf) 
if nargin<3
    mf=fs/2;
end
N=length(x);
%����ֱ������
x=x-mean(x);
%����N(ż��)
N=floor(N/2)*2;
y=fft(x,N);
mag=abs(y)*2/N;
%mag=[mag(1)/2; mag(2:end)];
f=(0:length(y)-1)'*fs/length(y);
stop = floor(N/fs*mf);
plot(f(1:stop),mag(1:stop));
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('�����ź� ��Ƶ��ͼ');
grid;