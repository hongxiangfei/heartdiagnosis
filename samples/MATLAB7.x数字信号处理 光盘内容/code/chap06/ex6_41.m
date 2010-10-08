Fs = 1000;
nfft = 1024;
t = 0:1/Fs:1;
x = sin(2*pi*100*t) + 4*sin(2*pi*200*t) + sin(2*pi*400*t) + randn(size(t));
window1 = boxcar(100);
window2 = hamming(100);
window3 = blackman(100);
noverlap = 20;
[Pxx1, f1] = pwelch(x, window1, noverlap, nfft, Fs);
[Pxx2, f2] = pwelch(x, window2, noverlap, nfft, Fs);
[Pxx3, f3] = pwelch(x, window3, noverlap, nfft, Fs);
PXX1 = 10 * log10(Pxx1);
PXX2 = 10 * log10(Pxx2);
PXX3 = 10 * log10(Pxx3);
subplot(3, 1, 1)
plot(f1, PXX1);
title('矩形窗');
subplot(3, 1, 2)
plot(f2, PXX2);
title('海明窗');
subplot(3, 1, 3)
plot(f3, PXX3);
xlabel('频率(Hz)');
ylabel('功率谱(dB)');
title('布莱克曼窗');
