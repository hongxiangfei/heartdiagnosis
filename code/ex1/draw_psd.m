function [PP,f]=draw_psd(signal,fs,mf)
if nargin<3
    mf=fs/2;
end
nfft = fs/2 * 16;
[P0,f0] = pburg(signal,15,nfft,fs);
%×ª»¯³ÉdB
%Pxx0 = 10 * log10(P0/max(P0)+0.0001);
PdB0 = ptodb(P0,max(P0));

len = floor(nfft/fs*mf);
P = P0(1:len);
f = f0(1:len);
PP = P.*f;
PdB = PdB0(1:len);
% figure
% plot(f,PP)
% hold on
% xlabel('Frequency(Hz)');
% ylabel('Power Spectral Density');