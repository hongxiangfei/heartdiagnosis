clc;
clear;
%%
% ��ȡ��Ƶ�ź�
[y,Fs,NBITS,OPTS]=wavread('09.wav');
% ԭ������Fs=44100,����20���������ʱ�Ϊ2205
y=y(1:20:length(y),1);
Fs=Fs/20;
%z=denoise(y);
%% ��Ƶ��ͼ
% subplot(2,1,1)
% plot_spectrum(y,Fs,200)
% title('ԭʼ�ź�Ƶ��ͼ')
% subplot(2,1,2)
% plot_spectrum(z,Fs,200)
% title('ȥ����ź�Ƶ��ͼ')
draw_psd(y,Fs,200);
%% ��Ũ����
%z=z+0.0001;
%[elp,t]=shannon(z(1:22050),Fs);
% PCG=newextract(elp,t);
% [hrate,s1h,s1H,s2h,s2H]=features(PCG,Fs);