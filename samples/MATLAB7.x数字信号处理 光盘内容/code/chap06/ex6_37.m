Fs=2000;
NFFT=256;
n=0:1/Fs:1;
x=randn(size(n));
b=ones(1,5)/5;
y=filter(b,1,x);
[h,f]=tfe(x,y,NFFT,Fs,256,128,'none');
h0=freqz(b,1,f,Fs);
subplot(2,1,1)
plot(f,abs(h0));
title('理想传递函数的幅度');
xlabel('频率（Hz）');
subplot(2,1,2)
plot(f,abs(h));
title('估计的传递函数幅度');
xlabel('频率（Hz）');
