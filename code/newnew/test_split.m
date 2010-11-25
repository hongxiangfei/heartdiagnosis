%% 特征获取主程序
% hrate：心率，
% s1h:第一心音持续时间，
% s1H：第一心音幅值,
% s2h：第二心音时间,
% s2H：第二心音幅值,
% m1H：第一心音第一部分幅值,
% a2H：第二心音第二部分幅值,
% m1_t1：第一心音第一部分峰值到第二部分峰值所用的时间
% p2_a2：第一心音第一部分峰值到第二部分峰值所用的时间

%% 清理当前工作空间
clc
clear all

%% 读取心音数据
x = textread('PD1F18.027B');
%x = textread('PD3M20.011B');
%x = textread('PD3M20.013B');
%x = textread('PD4M6.299B');
% 心音频率
Fs = 6000;

%% 小波分解与重构(去噪)
y = denoise(x');

%% 希尔伯特包络提取
elps = envelope(y);

%% 香浓能量提取
elpSannon=Shannon(y, Fs);

%% 包络显示
show_envelope

%% 特征提取
PCGa = newextract_Shannon1(y,elpSannon,Fs);

S92=featuress_Shannon(PCGa,elp,Fs);
%  PCGa = newextractsplit_s4(elp,Fs);

