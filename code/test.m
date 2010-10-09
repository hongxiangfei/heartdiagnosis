clc;
clear;
%%
% 读取音频信号
[y,Fs,NBITS,OPTS] = wavread('09.wav');
% 原采样率Fs=44100,降低20倍，采样率变为2205
y = y(1:20:length(y),1);
Fs = Fs/20;
%取10S的心音数据
y = y(1:6*Fs);
%%每帧100ms，并且75%重复
frame = 0.1 * Fs;
factor = 0.75;
%z=denoise(y);
%% 画频谱图
% subplot(2,1,1)
% plot_spectrum(y,Fs,200)
% title('原始信号频谱图')
% subplot(2,1,2)
% plot_spectrum(z,Fs,200)
% title('去噪后信号频谱图')
%% AR模型
begin = 1;
ending = frame;
k = 1;
while(ending <= length(y))
    [P,f] = draw_psd(y(begin:ending),Fs,200);
    En(k) = findfreq(P,f);
    k = k + 1;
    
    begin = begin + frame * (1 - factor);
    ending = ending + frame * (1 - factor);
end
%% 香浓能量
%z=z+0.0001;
%[elp,t]=shannon(z(1:22050),Fs);
% PCG=newextract(elp,t);
% [hrate,s1h,s1H,s2h,s2H]=features(PCG,Fs);