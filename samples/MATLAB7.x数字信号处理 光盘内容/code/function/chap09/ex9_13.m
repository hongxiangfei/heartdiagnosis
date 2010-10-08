clear  all;
close  all;
clc;
fz=10e3;
tz=1/fz;
fs=8e6;
ts=1/fs;
f_doppler=2.5e3;
N=tz/ts;
%%%%%%%%%%%%%%产生雷达回波%%%%%%%%%%%%%%%
echo_mobj_pulse=[zeros(1,100),1,1,zeros(1,N-102)];
s_pc=repmat(echo_mobj_pulse,1,16);
n=1:16*N;
s_doppler=cos(n*2*pi*f_doppler/fs);
s_pc=s_pc.*s_doppler;
s_noise=0.1*rand(1,N*16);
s_pc=s_pc+s_noise;
figure,
plot(0:ts:(16*N-1)*ts,s_pc),xlabel('t(单位:s)'),title('回波信号');
s_pc=reshape(s_pc,N,16);
%%%%%%%%%%%%%采用FFT法进行MTD处理%%%%%%%%%%%
M=16;
s_mtd=zeros(N,16);
for i=1:N
    s_temp=s_pc(i,:);
    s_mtd(i,:)=fft(s_temp,M);
end
t=0:ts:tz-ts;
figure,
subplot(2,4,1),plot(t,abs(s_mtd(:,1))),title('多普勒滤波器组（第1通道）');
subplot(2,4,2),plot(t,abs(s_mtd(:,2))),title('多普勒滤波器组（第2通道）');
subplot(2,4,3),plot(t,abs(s_mtd(:,3))),title('多普勒滤波器组（第3通道）');
subplot(2,4,4),plot(t,abs(s_mtd(:,4))),title('多普勒滤波器组（第4通道）');
subplot(2,4,5),plot(t,abs(s_mtd(:,5))),title('多普勒滤波器组（第5通道）');
subplot(2,4,6),plot(t,abs(s_mtd(:,6))),title('多普勒滤波器组（第6通道）');
subplot(2,4,7),plot(t,abs(s_mtd(:,7))),title('多普勒滤波器组（第7通道）');
subplot(2,4,8),plot(t,abs(s_mtd(:,8))),title('多普勒滤波器组（第8通道）');
figure,
subplot(2,4,1),plot(t,abs(s_mtd(:,9))),title('多普勒滤波器组（第9通道）');
subplot(2,4,2),plot(t,abs(s_mtd(:,10))),title('多普勒滤波器组（第10通道）');
subplot(2,4,3),plot(t,abs(s_mtd(:,11))),title('多普勒滤波器组（第11通道）');
subplot(2,4,4),plot(t,abs(s_mtd(:,12))),title('多普勒滤波器组（第12通道）');
subplot(2,4,5),plot(t,abs(s_mtd(:,13))),title('多普勒滤波器组（第13通道）');
subplot(2,4,6),plot(t,abs(s_mtd(:,14))),title('多普勒滤波器组（第14通道）');
subplot(2,4,7),plot(t,abs(s_mtd(:,15))),title('多普勒滤波器组（第15通道）');
subplot(2,4,8),plot(t,abs(s_mtd(:,16))),title('多普勒滤波器组（第16通道）');

%%%%%%%%%%%%%采用FIR法进行MTD处理%%%%%%%%%%%
B=fz/16;
[b(1,:),a(1,:)]=fir1(50,B/fz);
[b(2,:),a(2,:)]=fir1(50,[eps,1*B/fz]);
[b(3,:),a(3,:)]=fir1(50,[1*B/fz,2*B/fz]);
[b(4,:),a(4,:)]=fir1(50,[2*B/fz,3*B/fz]);
[b(5,:),a(5,:)]=fir1(50,[3*B/fz,4*B/fz]);
[b(6,:),a(6,:)]=fir1(50,[4*B/fz,5*B/fz]);
[b(7,:),a(7,:)]=fir1(50,[5*B/fz,6*B/fz]);
[b(8,:),a(8,:)]=fir1(50,[6*B/fz,7*B/fz]);
[b(9,:),a(9,:)]=fir1(50,[7*B/fz,8*B/fz]);
[b(10,:),a(10,:)]=fir1(50,[8*B/fz,9*B/fz]);
[b(11,:),a(11,:)]=fir1(50,[9*B/fz,10*B/fz]);
[b(12,:),a(12,:)]=fir1(50,[10*B/fz,11*B/fz]);
[b(13,:),a(13,:)]=fir1(50,[11*B/fz,12*B/fz]);
[b(14,:),a(14,:)]=fir1(50,[12*B/fz,13*B/fz]);
[b(15,:),a(15,:)]=fir1(50,[13*B/fz,14*B/fz]);
[b(16,:),a(16,:)]=fir1(50,[14*B/fz,15*B/fz-eps]);
s_mtd_fir=zeros(N,40);
s_pc=[s_pc,zeros(N,33)];
for k=1:16
    for i=1:N
        bb=b(k,:);
        aa=a(k,:);
        s_temp=s_pc(i,:);
        s_mtd_temp(i,:)=filter(bb,aa,s_temp);
    end
    s_mtd_fir(:,k)=s_mtd_temp(:,end);
end
t=0:ts:tz-ts;
figure,
subplot(2,4,1),plot(t,abs(s_mtd_fir(:,1))),title('多普勒滤波器组（第1通道）');
subplot(2,4,2),plot(t,abs(s_mtd_fir(:,2))),title('多普勒滤波器组（第2通道）');
subplot(2,4,3),plot(t,abs(s_mtd_fir(:,3))),title('多普勒滤波器组（第3通道）');
subplot(2,4,4),plot(t,abs(s_mtd_fir(:,4))),title('多普勒滤波器组（第4通道）');
subplot(2,4,5),plot(t,abs(s_mtd_fir(:,5))),title('多普勒滤波器组（第5通道）');
subplot(2,4,6),plot(t,abs(s_mtd_fir(:,6))),title('多普勒滤波器组（第6通道）');
subplot(2,4,7),plot(t,abs(s_mtd_fir(:,7))),title('多普勒滤波器组（第7通道）');
subplot(2,4,8),plot(t,abs(s_mtd_fir(:,8))),title('多普勒滤波器组（第8通道）');
figure,
subplot(2,4,1),plot(t,abs(s_mtd_fir(:,9))),title('多普勒滤波器组（第9通道）');
subplot(2,4,2),plot(t,abs(s_mtd_fir(:,10))),title('多普勒滤波器组（第10通道）');
subplot(2,4,3),plot(t,abs(s_mtd_fir(:,11))),title('多普勒滤波器组（第11通道）');
subplot(2,4,4),plot(t,abs(s_mtd_fir(:,12))),title('多普勒滤波器组（第12通道）');
subplot(2,4,5),plot(t,abs(s_mtd_fir(:,13))),title('多普勒滤波器组（第13通道）');
subplot(2,4,6),plot(t,abs(s_mtd_fir(:,14))),title('多普勒滤波器组（第14通道）');
subplot(2,4,7),plot(t,abs(s_mtd_fir(:,15))),title('多普勒滤波器组（第15通道）');
subplot(2,4,8),plot(t,abs(s_mtd_fir(:,16))),title('多普勒滤波器组（第16通道）');

%%%%%%%%%%%%%FIR滤波器组频率响应%%%%%%%%%%%
figure,
freqz(b(1,:),a(1,:));hold on;
freqz(b(2,:),a(2,:));hold on;
freqz(b(3,:),a(3,:));hold on;
freqz(b(4,:),a(4,:));hold on;
freqz(b(5,:),a(5,:));hold on;
freqz(b(6,:),a(6,:));hold on;
freqz(b(7,:),a(7,:));hold on;
freqz(b(8,:),a(8,:));hold on;
freqz(b(9,:),a(9,:));hold on;
freqz(b(10,:),a(10,:));hold on;
freqz(b(11,:),a(11,:));hold on;
freqz(b(12,:),a(12,:));hold on;
freqz(b(13,:),a(13,:));hold on;
freqz(b(14,:),a(14,:));hold on;
freqz(b(15,:),a(15,:));hold on;
freqz(b(16,:),a(16,:));hold on;



