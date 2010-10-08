function [y] =  hsolpsav(x,h,N)
% 用FFT的高速混叠法作循环卷积
% --------------------------------------------------------------
% [y] = hsolpsav(x,h,N)
% y = 输出序列
% x = 输入序列
% h = 脉冲响应
% N = 块长(必须是二的幂次)
%
N = 2^(ceil(log10(N)/log10(2));
Lenx = length(x); M = length(h);
M1 = M-1; L = N-M1;
h = fft(h,N);
%
x = [zeros(1,M1), x, zeros(1,N-1)];
K = floor((Lenx+M1-1)/(L)); % 块的数目
Y = zeros(K+1,N);
for k=0:K
	xk = fft(x(k*L+1:k*L+N));
	Y(k+1,:) = real(ifft(xk.*h));
end
Y = Y(:,M:N)'; y = (Y(:))';
