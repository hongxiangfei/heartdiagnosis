Fs = 1000;     % ����Ƶ��
NFFT = 256;
t = 0:1/Fs:1;  % ����ʱ��
x = sin(2*pi*100*t) + sin(2*pi*200*t) + sin(2*pi*400*t) + randn(size(t));
w = hanning(NFFT)'; % 256����ĺ�������ע��ȡת��
Pxx = (abs(fft(w.*x(1:NFFT))).^2 + ...
       abs(fft(w.*x(NFFT*1/2 + 1:NFFT*3/2))).^2 + ...
       abs(fft(w.*x(NFFT*2/2 + 1:NFFT*4/2))).^2 + ...
       abs(fft(w.*x(NFFT*3/2 + 1:NFFT*5/2))).^2 + ...
       abs(fft(w.*x(NFFT*4/2 + 1:NFFT*6/2))).^2 + ...
       abs(fft(w.*x(NFFT*5/2 + 1:NFFT*7/2))).^2) / (norm(w)^2*6);
f = (0:(NFFT-1))./NFFT*Fs;       % ������任
PXX = 10 * log10(Pxx);           % ������任
figure
plot(f, PXX);
xlabel('Ƶ�ʣ�Hz��');
ylabel('�����ף�dB��');
grid;
