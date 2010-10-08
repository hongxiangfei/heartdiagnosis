clear  all;
close  all;
clc;
%%%%%%%%%%%%%%%产生雷达发射信号%%%%%%%%%%%%%%%%%%
code=[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];  %13位巴克码
tao=0.5e-6;%脉冲宽度10us
f0=10e6;
fs=40e6;   %采样频率l00MHz
ts=1/fs;
t_tao=0:1/fs:tao-1/fs;
n=length(code);
N=length(t_tao);
pha=0;
t=0:1/fs:13*tao-1/fs;
s=zeros(1,length(t));
for i=1:n;
    if code(i)==1
        pha=pi;
    else pha=0;
    end
    s(1,(i-1)*N+1:i*N)=cos(2*pi*f0*t_tao+pha);
end
figure(1),subplot(2,1,1),plot(t,s),xlabel('t(单位:s)'),title('混合调制信号(13位巴克码+线性调频)');
s_fft_result=abs(fft(s(1:N)));
subplot(2,1,2),plot((0:fs/N:fs/2-fs/N),abs(s_fft_result(1:N/2))),xlabel('频率(单位:Hz)'),title('码内信号频谱');
%___________正交解调_________________%
N=length(t);
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);%i路本振信号
local_oscillator_q=sin(n*f0/fs*2*pi);%q路本振信号
fbb_i=local_oscillator_i.*s;%i路解调
fbb_q=local_oscillator_q.*s;%q路解调
window=chebwin(51,40);
[b,a]=fir1(50, 0.5,window);
fbb_i=[fbb_i,zeros(1,25)];
fbb_q=[fbb_q,zeros(1,25)];
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);
fbb_i=fbb_i(26:end);%截取有效倍息
fbb_q=fbb_q(26:end);%截取有效信息
fbb=fbb_i+j*fbb_q;

%--------产生理想线性调频脉冲压缩匹配系数--------%
M=131072;%因为回波信号数据长度为3600点,所以利用FFT,做4096点FFT
t1=100e-6;
t=tao*length(code);
match_filter=2*ts*fliplr(conj(fbb))*2/t;
match_filter_fft=fft(match_filter,M);%第-次脉冲压缩处理匹配系数
figure(2),
subplot(2,1,1),plot(real(match_filter_fft)),title('脉冲压缩系数(实部)');
subplot(2,1,2),plot(imag(match_filter_fft)),title('脉冲压缩系数(虚部)');
%%%%%%产生理想点目标回波信号%%%%%%%%
signal=[zeros(1,(t1-2*t)/ts),s,zeros(1,t/ts)];
%%%%% 正交解调%%%%%
N=length(signal);
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);%i路本振信号
local_oscillator_q=sin(n*f0/fs*2*pi);%q路本振信号

fbb_i=local_oscillator_i.*signal;%i路解调
fbb_q=local_oscillator_q.*signal;%q路解调
window=chebwin(51,40);%这是采用50阶cheby窗的FIR低通滤波器

[b,a]=fir1(50, 0.5,window);
fbb_i=[fbb_i,zeros(1,25)];
fbb_q=[fbb_q,zeros(1,25)];
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);
fbb_i=fbb_i(26:end);%截取有效倍息
fbb_q=fbb_q(26:end);%截取有效信息
signal=fbb_i+j*fbb_q;
clear fbb_i;
clear fbb_q;
%%%%%%%%%%%脉压处理%%%%%%%%%%
signal_fft=fft(signal,M);
pc_result_fft=signal_fft.*match_filter_fft;
pc_result=ifft(pc_result_fft,M);
figure(3),
subplot(2,1,1),plot((0:ts:t1-ts),signal),xlabel('时间,单位:s'),
title('回波信号（解调后）');
subplot(2,1,2),plot((0:ts:length(signal)*ts-ts),abs(pc_result(1:length(signal)))), 
xlabel('时间,单位:s'),
title('回波脉冲压缩处理结果');
