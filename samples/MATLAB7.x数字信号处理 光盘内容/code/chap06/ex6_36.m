Fs=2000;
NFFT=1024;
n=0:1/Fs:1;
x=sin(2*pi*100*n)+4*sin(2*pi*500*n)+randn(size(n));  % ��������
Cx=xcorr(x,'unbiased');        % �������е�����غ���
Cxk=fft(Cx,NFFT);            % ����FFT
pxx=abs(Cxk);                % ���PSD
t=0:round(NFFT/2-1);
k=t*Fs/NFFT;
P=10*log(pxx(t+1));           % ������ĵ�λΪdB
plot(k,P);
