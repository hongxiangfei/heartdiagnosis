clear all
close all
clc

%%%%%%%%%%%%%%%产生信号回波%%%%%%%%%%%%%%%%%%
fz=10e3;
tz=1/fz;
fs=8e6;
ts=1/fs;
f_doppler=7e3;
N=tz/ts;
M=16;
s_pc_i=[zeros(1,100),1,1,zeros(1,N-102)];
s_pc_q=[zeros(1,100),-1,-1,zeros(1,N-102)];
s_pc_i=repmat(s_pc_i,1,M);
s_pc_q=repmat(s_pc_q,1,M);
s_noise=0.3*rand(N,16)+j*0.3*rand(N,16);
s_pc_i=reshape(s_pc_i,N,M);
s_pc_q=reshape(s_pc_q,N,M);
s_pc=s_pc_i+j*s_pc_q+s_noise;
s_pc_abs=abs(s_pc);
figure,plot([0:ts:(N-1)*ts],s_pc_abs(:,1)),xlabel('t'),title('回波求模后结果');
%%%%%%%%%%计算回波信号的信噪比%%%%%%%%%%%%%%
for i=1:M
    s_pc_signal_power=sqrt(s_pc_abs(100,i)^2+s_pc_abs(101,i)^2)/2;
    s_pc_noise=[s_pc_abs(1:99,i);s_pc_abs(102:end,i)];
    s_pc_noise_power=sqrt(sum(s_pc_noise.^2))/(N-2);
    s_pc_SNR(i)=20*log10(s_pc_signal_power/s_pc_noise_power)
end
%%%%%%%%%%%%非相参积累%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    fir_accumulation_result(i)=sum(s_pc_abs(i,:))/M;
end
figure,plot([0:ts:(N-1)*ts],fir_accumulation_result),xlabel('t'),title('非相参积累处理结果');

%%%%%%%%%计算非相参积累处理后信噪比%%%%%%%%%%%%
fir_accumulation_result_signal_power=sqrt(fir_accumulation_result(100)^2+fir_accumulation_result(101)^2)/2;
fir_accumulation_result_noise=[fir_accumulation_result(1:99),fir_accumulation_result(102:end)];
fir_accumulation_result_noise_power=sqrt(sum(fir_accumulation_result_noise.^2))/(N-2);
fir_accumulation_SNR=20*log10(fir_accumulation_result_signal_power/fir_accumulation_result_noise_power);

%%%%%%%%%%%相参积累%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    coherent_accumulation_result_i(i)=sum(real(s_pc(i,:)))/M;
    coherent_accumulation_result_q(i)=sum(imag(s_pc(i,:)))/M;
end
coherent_accumulation_result=coherent_accumulation_result_i+j*coherent_accumulation_result_q;
coherent_accumulation_result_abs=abs(coherent_accumulation_result);
figure,plot([0:ts:(N-1)*ts],coherent_accumulation_result_abs),xlabel('t'),title('相参积累处理结果');

%%%%%%%%%计算相参积累后信噪比%%%%%%%%%%%%%%%
coherent_accumulation_result_signal_power=sqrt(coherent_accumulation_result(100)^2+coherent_accumulation_result(101)^2)/2;
coherent_accumulation_result_noise=[coherent_accumulation_result(1:99),coherent_accumulation_result(102:end)];
coherent_accumulation_result_noise_power=sqrt(sum(coherent_accumulation_result_noise.^2))/(N-2);
coherent_accumulation_SNR=20*log10(coherent_accumulation_result_signal_power/coherent_accumulation_result_noise_power);
