function [P,f]=draw_psd(signal,fs,mf)
if nargin<3
    mf=fs/2;
end
nfft = length(signal);
[P,f] = pburg(signal,floor(fs/40),nfft,fs);
Pxx = 10 * log10(P/max(P)+0.0001);
figure
len = floor(nfft/fs*mf);
plot(f(1:len),Pxx(1:len))
grid on;
xlabel('Frequency(Hz)');
ylabel('Amplitude(dB)');