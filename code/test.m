clc;
clear;
%%
% ��ȡ��Ƶ�ź�
[y,Fs,NBITS,OPTS] = wavread('09.wav');
% ԭ������Fs=44100,����20���������ʱ�Ϊ2205
y = y(1:20:length(y),1);
Fs = Fs/20;
%ȡ10S����������
y = y(1:6*Fs);
%%ÿ֡100ms������75%�ظ�
frame = 0.1 * Fs;
factor = 0.75;
%z=denoise(y);
%% ��Ƶ��ͼ
% subplot(2,1,1)
% plot_spectrum(y,Fs,200)
% title('ԭʼ�ź�Ƶ��ͼ')
% subplot(2,1,2)
% plot_spectrum(z,Fs,200)
% title('ȥ����ź�Ƶ��ͼ')
%% ARģ��
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
%% ��Ũ����
%z=z+0.0001;
%[elp,t]=shannon(z(1:22050),Fs);
% PCG=newextract(elp,t);
% [hrate,s1h,s1H,s2h,s2H]=features(PCG,Fs);