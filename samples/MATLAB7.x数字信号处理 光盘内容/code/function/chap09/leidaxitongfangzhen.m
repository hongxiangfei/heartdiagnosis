close  all;
clear  a11;
clc;
%%%%%%%�����״﷢���ź�%%%%%%%%%%%%%%%%%%
code=[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];  %13λ�Ϳ���
tao=10e-6;%������10us
fc=28e6;%��Ƶ�ź���ʼƵ��
f0=30e6;
fs=100e6;   %����Ƶ��l00MHz
ts=1/fs;
B=4e6;%��Ƶ�źŴ���
t_tao=0:1/fs:tao-1/fs;
N=length(t_tao);
k=B/fs*2*pi/max(t_tao);
n=length(code);
pha=0;
s=zeros(1,n*N);
for i=1:n;
    if code(i)==1
        pha=pi;
    else pha=0;
    end
    s(1,(i-1)*N+1:i*N)=cos(2*pi*fc*t_tao+k*cumsum(t_tao)+pha);
end
t=0:1/fs:13*tao-1/fs;
figure(1),subplot(2,1,1),plot(t,s),xlabel('t(��λ:s)'),title('��ϵ����ź�(13λ�Ϳ���+���Ե�Ƶ)');
s_fft_result=abs(fft(s(1:N)));
subplot(2,1,2),plot((0:fs/N:fs/2-fs/N),abs(s_fft_result(1:N/2))),xlabel('Ƶ��(��λ:Hz)'),title('�����ź�Ƶ��');
%%%%%%%%%%%%%%%������ѹ��ϵ��%%%%%%%%%%%%%%%
%___________�������_________________%
N=tao/ts;
n=0:N-1;
s1=s(1:N);
local_oscillator_i=cos(n*f0/fs*2*pi);%i·�����ź�
local_oscillator_q=sin(n*f0/fs*2*pi);%q·�����ź�
fbb_i=local_oscillator_i.*s1;%i·���
fbb_q=local_oscillator_q.*s1;%q·���
window=chebwin(51,40);
[b,a]=fir1(50, 2*B/fs,window);
fbb_i=[fbb_i,zeros(1,25)];
fbb_q=[fbb_q,zeros(1,25)];
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);
fbb_i=fbb_i(26:end);%��ȡ��Ч��Ϣ
fbb_q=fbb_q(26:end);%��ȡ��Ч��Ϣ
fbb=fbb_i+j*fbb_q;
%--------�����������Ե�Ƶ����ѹ��ƥ��ϵ��--------%
M=131072;%��Ϊ�ز��ź����ݳ���Ϊ3600��,��������FFT,��4096��FFT
D=B*tao;
match_filter_1=ts*fliplr(conj(fbb))*sqrt(D)*2/tao;
match_filter_1_fft=fft(match_filter_1,M);%��-������ѹ������ƥ��ϵ��
figure(2),
subplot(2,1,1),plot(real(match_filter_1_fft)),title('����ѹ��ϵ��(ʵ��)');
subplot(2,1,2),plot(imag(match_filter_1_fft)),title('����ѹ��ϵ��(�鲿)');
N=length(s);
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);%i·�����ź�
local_oscillator_q=sin(n*f0/fs*2*pi);%q·�����ź�
fbb_i=local_oscillator_i.*s;%i·���
fbb_q=local_oscillator_q.*s;%q·���
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
signal_fft=fft(signal,M);
pc_result_fft=signal_fft.*match_filter_1_fft;
pc_result=ifft(pc_result_fft,M);
figure(3),plot((0:ts:length(signal)*ts-ts),pc_result(1:length(signal))), xlabel('ʱ��,��λ:s'),
title('�ز�����ѹ��������');
clear  local_oscillator_i;
clear  local_oscillator_q;
t=tao*length(code);
match_filter_2=2*ts*fliplr(conj(pc_result))*2/t;
match_filter_2_fft=fft(match_filter_2,M);%�ڶ�������ѹ������ƥ��ϵ��
figure,
subplot(2,1,1),plot(real(match_filter_2_fft)),title('����ѹ��ϵ����ʵ����');
subplot(2,1,2),plot(imag(match_filter_2_fft)),title('����ѹ��ϵ�����鲿��')
clear  fbb;
clear  match_fllter_1;
clear  match_filter_2;
clear  signal;
clear  signal_fft;
clear  pc_result;
clear  pc_result_fft;
%%%%%%%%%%%%%%%�����״�ز�%%%%%%%%%%%%%%%
f_frame=1e3;%�״﷢���ź���Ƶ,��λHz
T_frame=1/f_frame;
N_echo_frame=18;
f_doppler=3.5e3;%��Ŀ��Ķ������촮
t_frame=0:ts:T_frame-ts;
t_mobj=200e-6;%��Ŀ��λ��
echo_mobj_pulse=[zeros(1,t_mobj/ts),s,zeros(1,(T_frame-t_mobj)/ts-length(s))];
echo_mobj=repmat(echo_mobj_pulse,1,N_echo_frame);
t_doppler=0:ts:N_echo_frame*T_frame-ts;
s_doppler=cos(2*pi*f_doppler*t_doppler);
s_echo_mobj=echo_mobj.*s_doppler;
t_fobj=450e-6;%�̶�Ŀ��λ��
echo_fobj_pulse=[zeros(1,t_fobj/ts),s,zeros(1,(T_frame-t_fobj)/ts-length(s))];
s_echo_fobj=repmat(echo_fobj_pulse,1,N_echo_frame);
t_clutter=700e-6;%�Ӳ�λ��
t_clutter_pulse=39e-6;
sigma=2;%�����ֲ�canshu��sigma
t1=0:ts:t_clutter_pulse-ts;
rand('state',0);%�Ѿ��ȷֲ�α�����������Ϊ0״̬
u=rand(1,length(t1));
echo_clutter=0.08*sqrt(2*log(1./u))*sigma;%,*s;
s_echo_clutter_pulse=[zeros(1,t_clutter/ts),echo_clutter,zeros(1,(T_frame-t_clutter)/ts-length(echo_clutter))];
s_echo_clutter=repmat(s_echo_clutter_pulse,1,N_echo_frame);
s_noise=0.1*rand(1,N_echo_frame*T_frame/ts);
s_echo=s_echo_mobj+s_echo_fobj+s_echo_clutter+s_noise;
clear s_echo_mobj;
clear s_echo_fobj;
clear s_echo_clultter;
clear s_echo_clutter_pulse;
clear s_noise;
clear echo_mobj_pulse;
clear echo_mobj;
clear echo_fobj_pulse;
clear echo_clutter;
clear s_doppler;
clear t_doppler;
%----------�������------%
N=N_echo_frame*T_frame/ts;
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*pi);%I·�����ź�
local_oscillator_q=sin(n*f0/fs*pi);%q·�����ź�
s_echo_i=local_oscillator_i.*s_echo;%I·���
s_echo_q=local_oscillator_q.*s_echo;%q·���
window=chebwin(51,40);%���ǲ�50��cheby����FIR��ͨ�˲���
[b,a]=fir1(50,2*B/fs,window);
s_echo_i=[s_echo_i,zeros(1,25)];
s_echo_q=[s_echo_q,zeros(1,25)];
s_echo_i=filter(b,a,s_echo_i);
s_echo_q=filter(b,a,s_echo_q);
s_echo_i=s_echo_i(26:end);%��ȡ��Ч��Ϣ
s_echo_q=s_echo_q(26:end);%��ȡ��Ч��Ϣ
s_echo_mf=s_echo_i+j*s_echo_q;

clear s_echo;
clear local_oscillator_i;
clear local_oscillator_q;
clear s_echo_i;
clear s_eche_q;
clear n;
%%%%%%%%%%%%%%%%%%%%����ѹ������%%%%%%%%%%%%%
for i=1:N_echo_frame
    s_echo_fft_result=fft(s_echo_mf(1,(i-1)*T_frame/ts+1:i*T_frame/ts),M);
    s_pc_fft_1=s_echo_fft_result.*match_filter_1_fft;
    s_pc_fft_2=s_pc_fft_1.*match_filter_2_fft;
    s_pc_result(i,:)=ifft(s_pc_fft_2,M);
end
clear s_echo_mf;
s_pc_result_1=s_pc_result';
s_pc_result_1=reshape(s_pc_result_1,1,N_echo_frame*M);
figure,subplot(2,1,1),plot(0:ts:length(s_pc_result_1)*ts-ts,real(s_pc_result_1)),
%N_echo_frame*T_frame-ts
xlabel('t(��λ:s)'),title('����ѹ���������(ʵ��)');
subplot(2,1,2),plot(0:ts:length(s_pc_result_1)*ts-ts,imag(s_pc_result_1)),
xlabel('t(��λ:s)'),title('����ѹ���������(�鲿)');
%%%%%%%%%%%%%%5�̶��Ӳ���������%%%%%%%%%%%%%%
for i=1:16
    s_MTI_result(i,:)=s_pc_result(i,:)+s_pc_result(i+2,:)-2*s_pc_result(i+1,:);
end
clear s_pc_result;
clear s_pc_result_1;
s_MTI_result_1=s_MTI_result';
s_MTI_result_1=reshape(s_MTI_result_1,1,(N_echo_frame-2)*M);
figure,subplot(2,1,1),plot(0:ts:length(s_MTI_result_1)*ts-ts,real(s_MTI_result_1)),
xlabel('t(��λ:s)'),title('�̶��Ӳ����������(ʵ��)');
subplot(2,1,2),plot(0:ts:length(s_MTI_result_1)*ts-ts,imag(s_MTI_result_1)),
xlabel('t(��λ:s)'),title('�̶��Ӳ����������(�鲿)');
clear s_MTI_result_1;
%%%%%%%%%%%%%%%%MTD�������ģ%%%%%%%%
%for i=1:T_frame/ts
 %   s_MTD_result_1(:,i)=fft(s_MTI_result(:,i),16);
 %end
%for i=1:T_frame/ts
%    s_MTD_result(i)=abs(s_MTD_result_1);
%end
%figure,plot(0:ts:N_echo_frame*T_frame-ts,s_MTD_result),
%xlabel('t(��λ:s)'),title('MTD�������ģ������ź����ͨ����');
for i=1:T_frame/ts
    s_MTD_result_1(:,i)=fft(s_MTI_result(:,i),16);
end
for i=1:T_frame/ts
    s_MTD_result(i)=abs(max(s_MTD_result_1(i)));
end
figure,plot(0:ts:T_frame-ts,s_MTD_result),
xlabel('t(��λ:s)'),title('MTD�������ģ������ź����ͨ����');
%%%%%%%%%CFAR����%%%%%%%%%%%%%%%%%%%%%%%t
N=T_frame/ts;
cfar_result(1,1)=s_MTD_result(1,1)/(sqrt(2)/pi*mean(s_MTD_result(1,2:17)));
%��l�㻸��Ƴ����ʱ������ֵ��������l6�����������
for i=2:16
%��2�㵽��16��ĺ��龯�����������������ǰ��ͺ���l6���������ͬ����
    noise_mean=sqrt(2)/pi*(mean(s_MTD_result(1,1:i-1))+mean(s_MTD_result(1,i+1:i+16)))/2;
    cfar_result(1,i)=s_MTD_result(1,i)/noise_mean;
end
for i=17:N-17
%���������ݵ�ĺ��龯�����������ֵ����ǰ��ͺ����26�����������
    noise_mean=sqrt(2)/pi*max(mean(s_MTD_result(1,i-16:i-1)),mean(s_MTD_result(1,i+1:i+16)));
    cfar_result(1,i)=s_MTD_result(1,i)/noise_mean;
end
for k=N-16:N-1
%������l6�㵽������2����龯�����������ֵ����ǰ��16�ͺ����������ͬ����
    noise_mean=sqrt(2)/pi*(mean(s_MTD_result(1,k-16:k-1))+mean(s_MTD_result(1,k+1:N)))/2;
    cfar_result(1,k)=s_MTD_result(1,k)/noise_mean;
end
%���1��Ļ��龯�����������ֵ����ǰ��l6�����������
    cfar_result(1,N)=s_MTD_result(1,N)/(sqrt(2)/pi*mean(s_MTD_result(1,N-16:N-1)));
figure,plot(0:ts:N*ts-ts,cfar_result),xlabel('t(��λ:s)'),title('���ú��龯��������');
