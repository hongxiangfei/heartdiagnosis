%% ������ȡ������
% hrate�����ʣ�
% s1h:��һ��������ʱ�䣬
% s1H����һ������ֵ,
% s2h���ڶ�����ʱ��,
% s2H���ڶ�������ֵ,
% m1H����һ������һ���ַ�ֵ,
% a2H���ڶ������ڶ����ַ�ֵ,
% m1_t1����һ������һ���ַ�ֵ���ڶ����ַ�ֵ���õ�ʱ��
% p2_a2����һ������һ���ַ�ֵ���ڶ����ַ�ֵ���õ�ʱ��

%% ����ǰ�����ռ�
clc
clear all

%% ��ȡ��������
x = textread('PD1F18.027B');
%x = textread('PD3M20.011B');
%x = textread('PD3M20.013B');
%x = textread('PD4M6.299B');
% ����Ƶ��
Fs = 6000;

%% С���ֽ����ع�(ȥ��)
y = denoise(x');

%% ϣ�����ذ�����ȡ
elps = envelope(y);

%% ��Ũ������ȡ
elpSannon=Shannon(y, Fs);

%% ������ʾ
show_envelope

%% ������ȡ
PCGa = newextract_Shannon1(y,elpSannon,Fs);

S92=featuress_Shannon(PCGa,elp,Fs);
%  PCGa = newextractsplit_s4(elp,Fs);

