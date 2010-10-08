Fs=1000;
NFFT=256;
p=0.95;   % 置信度
[b,a] = ellip(6,2,50,0.2);  % 设计６阶椭圆型滤波器
r=randn(4096,1);
x=filter(b,a,r);         % 对白噪声滤波得到信号x
psd(x,NFFT,Fs,[],0,p);  %　PSD估计
