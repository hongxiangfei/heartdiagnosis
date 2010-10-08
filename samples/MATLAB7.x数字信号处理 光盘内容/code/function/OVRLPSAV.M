function [y] = ovrlpsav(x,h,N)
% 用混叠相加法作块卷积
% ----------------------------------------
% [y] = ovrlpsav(x,h,N)
% y = 输出序列
% x = 输入序列
% h = 脉冲响应
% N = 块长
%
Lenx = length(x); M = length(h);
M1 = M-1; L = N-M1;
h = [h zeros(1,N-M)];
%
x = [zeros(1,M1), x, zeros(1,N-1)]; % 预置 (M-1) 个零
K = floor((Lenx+M1-1)/(L));         %块数
Y = zeros(K+1,N);
% 与后续各块卷积
for k=0:K
	xk = x(k*L+1:k*L+N);
	Y(k+1,:) = circonvt(xk,h,N);
end
Y = Y(:,M:N)';                      % 去掉前(M-1) 个样本
y = (Y(:))';                        % 装成输出
