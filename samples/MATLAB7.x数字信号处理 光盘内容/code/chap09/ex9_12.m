clear  all;
close  all;
clc;
%%%%%%%%%%%%%%%�����״﷢���ź�%%%%%%%%%%%%%%%%%%
code=[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];  %13λ�Ϳ���
tao=0.5e-6;%������10us
f0=10e6;
fs=40e6;   %����Ƶ��l00MHz
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
figure(1),subplot(2,1,1),plot(t,s),xlabel('t(��λ:s)'),title('��ϵ����ź�(13λ�Ϳ���+���Ե�Ƶ)');
s_fft_result=abs(fft(s(1:N)));
subplot(2,1,2),plot((0:fs/N:fs/2-fs/N),abs(s_fft_result(1:N/2))),xlabel('Ƶ��(��λ:Hz)'),title('�����ź�Ƶ��');
%___________�������_________________%
N=length(t);
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);%i·�����ź�
local_oscillator_q=sin(n*f0/fs*2*pi);%q·�����ź�
fbb_i=local_oscillator_i.*s;%i·���
fbb_q=local_oscillator_q.*s;%q·���
window=chebwin(51,40);
[b,a]=fir1(50, 0.5,window);
fbb_i=[fbb_i,zeros(1,25)];
fbb_q=[fbb_q,zeros(1,25)];
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);
fbb_i=fbb_i(26:end);%��ȡ��Ч��Ϣ
fbb_q=fbb_q(26:end);%��ȡ��Ч��Ϣ
fbb=fbb_i+j*fbb_q;

%--------�����������Ե�Ƶ����ѹ��ƥ��ϵ��--------%
M=131072;%��Ϊ�ز��ź����ݳ���Ϊ3600��,��������FFT,��4096��FFT
t1=100e-6;
t=tao*length(code);
match_filter=2*ts*fliplr(conj(fbb))*2/t;
match_filter_fft=fft(match_filter,M);%��-������ѹ������ƥ��ϵ��
figure(2),
subplot(2,1,1),plot(real(match_filter_fft)),title('����ѹ��ϵ��(ʵ��)');
subplot(2,1,2),plot(imag(match_filter_fft)),title('����ѹ��ϵ��(�鲿)');
%%%%%%���������Ŀ��ز��ź�%%%%%%%%
signal=[zeros(1,(t1-2*t)/ts),s,zeros(1,t/ts)];
%%%%% �������%%%%%
N=length(signal);
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);%i·�����ź�
local_oscillator_q=sin(n*f0/fs*2*pi);%q·�����ź�

fbb_i=local_oscillator_i.*signal;%i·���
fbb_q=local_oscillator_q.*signal;%q·���
window=chebwin(51,40);%���ǲ���50��cheby����FIR��ͨ�˲���

[b,a]=fir1(50, 0.5,window);
fbb_i=[fbb_i,zeros(1,25)];
fbb_q=[fbb_q,zeros(1,25)];
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);
fbb_i=fbb_i(26:end);%��ȡ��Ч��Ϣ
fbb_q=fbb_q(26:end);%��ȡ��Ч��Ϣ
signal=fbb_i+j*fbb_q;
clear fbb_i;
clear fbb_q;
%%%%%%%%%%%��ѹ����%%%%%%%%%%
signal_fft=fft(signal,M);
pc_result_fft=signal_fft.*match_filter_fft;
pc_result=ifft(pc_result_fft,M);
figure(3),
subplot(2,1,1),plot((0:ts:t1-ts),signal),xlabel('ʱ��,��λ:s'),
title('�ز��źţ������');
subplot(2,1,2),plot((0:ts:length(signal)*ts-ts),abs(pc_result(1:length(signal)))), 
xlabel('ʱ��,��λ:s'),
title('�ز�����ѹ��������');
