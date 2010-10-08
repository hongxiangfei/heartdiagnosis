clear all;
close all;
clc;
%%%%%%%%%%%������������%%%%%%%%%%%%%%%%%%%%%%%
sigma=2;
t=1e-3;
fs=1e6;
ts=1/fs;
t1=0.05e-3:1/fs:0.2e-3-1/fs;
n=length(t1);
rand('state',0);
u=rand(1,n);
rayleigh_noise=sqrt(2*log2(1./u))*sigma;

%%%%%%%%%%%%����Ŀ��ز�%%%%%%%%%%%%%%%%%%%
N=t/ts;
s_pc_1=[zeros(1,100),1,zeros(1,N-101)];
noise=rand(1,N);
rayleigh_clutter=[zeros(1,50),rayleigh_noise,zeros(1,N-200)];
s_pc=s_pc_1+0.1*rayleigh_clutter+0.1*noise;
figure,plot((0:ts:t-ts),s_pc),
xlabel('t(��λ:s)'),title('�����������ֲ��Ӳ�����������Ŀ��ز�');

%%%%%%%%%%%%%�����޺��龯����%%%%%%%%%%%%%%%%%%%
 cfar_result=zeros(1,N);
 cfar_result(1,1)=s_pc(1,1);
 for i=2:N
     cfar_result(i)=s_pc(1,i)/mean(s_pc(1,1:i));
 end
 figure,plot((0:ts:t-ts),cfar_result),
xlabel('t(��λ:s)'),title('���������޴�����');

%%%%%%%%%%%%%%%�����޺��龯����%%%%%%%%%%%%%
cfar_k_result=zeros(1,N);

cfar_k_result(1,1)=s_pc(1,1)/(sqrt(2)/pi*mean(s_pc(1,2:17)));
 
%��l����龯����ʱ������ֵ��������l6�����������
for i=2:16
%��2�㵽��16��ĺ��龯�����������������ǰ��ͺ���l6���������ͬ����
    noise_mean=sqrt(2)/pi*(mean(s_pc(1,1:i-1))+mean(s_pc(1,i+1:i+16)))/2;
    cfar_k_result(1,i)=s_pc(1,i)/noise_mean;
end
for i=17:N-17
%���������ݵ�ĺ��龯�����������ֵ����ǰ��ͺ����26��������еľ���
    noise_mean=sqrt(2)/pi*max(mean(s_pc(1,i-16:i-1)),mean(s_pc(1,i+1:i+16)));
    cfar_k_result(1,i)=s_pc(1,i)/noise_mean;
end
for i=N-16:N-1
%������l6�㵽������2����龯�����������ֵ����ǰ��16�ͺ����������ͬ����
    noise_mean=sqrt(2)/pi*(mean(s_pc(1,i-16:i-1))+mean(s_pc(1,i+1:N)))/2;
    cfar_k_result(1,i)=s_pc(1,i)/noise_mean;
end
%���-��Ļ��龯�����������ֵ����ǰ��l6�����������
cfar_k_result(1,N)=s_pc(1,N)/(sqrt(2)/pi*mean(s_pc(1,N-16:N-1)));
figure,plot(0:ts:t-ts,cfar_k_result),xlabel('t(��λ:s)'),title('���ÿ����޺��龯��������');

