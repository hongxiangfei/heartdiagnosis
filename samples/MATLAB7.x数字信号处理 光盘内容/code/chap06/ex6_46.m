nfft = 1024;
fs = 1000;
t = 0:1/fs:1;
x = sin(2*pi*200*t) + randn(size(t));
[P1, f] = pmtm(x, 2, nfft, fs);
[P2, f] = pmtm(x, 4, nfft, fs);
[P3, f] = pmtm(x, 10, nfft, fs);
Pxx1 = 10 * log10(P1);
Pxx2 = 10 * log10(P2);
Pxx3 = 10 * log10(P3);
subplot(3, 1, 1)
plot(f, Pxx1);
xlabel('Nw=2');
subplot(3, 1, 2)
plot(f, Pxx2);
xlabel('Nw=4');
subplot(3, 1, 3)
plot(f, Pxx3);
xlabel('Nw=10'); 
