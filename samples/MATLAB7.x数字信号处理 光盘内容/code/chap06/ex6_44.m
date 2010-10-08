nfft = 1024;
fs = 1000;
t = 0:1/fs:1;
xn = sin(2*pi*100*t)+sin(2*pi*300*t)+sin(2*pi*450*t)+randn(size(t));
[P, f] = pburg(xn, 18, nfft, fs);
Pxx = 10 * log10(P);
figure
plot(f, Pxx);
grid on;
xlabel('ÆµÂÊ£¨Hz£©');
ylabel('·ù¶È£¨dB£©');
