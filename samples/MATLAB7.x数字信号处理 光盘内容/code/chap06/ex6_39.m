Fs = 1000;
NFFT = 1024;
p = 0.95;
H = fir1(40, 0.5, boxcar(41));
h = ones(1, 10) / sqrt(10);
r = randn(4096, 1);
x = filter(h , 1, r);
y = filter(H, 1, x);
csd(x, y, NFFT, Fs, triang(500), 0, p);
