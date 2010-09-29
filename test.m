clc;
clear;
%%
% 读取音频信号
[y,Fs,NBITS,OPTS]=wavread('01 normal heart sound.wav');
% 原采样率Fs=44100,降低20倍，采样率变为2205
y=y(1:20:length(y),1);
Fs=Fs/20;
z=denoise(y);
%% 画频谱图
% subplot(2,1,1)
% plot_spectrum(y,Fs,200)
% title('原始信号频谱图')
% subplot(2,1,2)
% plot_spectrum(z,Fs,200)
% title('去噪后信号频谱图')
%% 香浓能量
z=z+0.0001;
shannon(z,Fs)