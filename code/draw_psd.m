function draw_psd(signal,fs,mf)
if nargin<3
    mf=fs/2;
end
nfft = 1024;
[P,f] = pburg(signal,32,nfft,fs);
Pxx = 10 * log10(P+0.0001);
figure
len = floor(nfft/fs*mf);
plot(f(1:len), Pxx(1:len));
grid on;
xlabel('ÆµÂÊ£¨Hz£©');
ylabel('·ù¶È£¨dB£©');