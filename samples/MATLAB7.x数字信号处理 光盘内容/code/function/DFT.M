function [Xk] = dft(xn,N)
% 计算离散付利叶变换
% -----------------------------------
% [Xk] = dft(xn,N)
% Xk = 在0 <= k <= N-1间的DFT 系数数组 
% xn = N点有限长度序列 
%  N = DFT的长度
%
n = [0:1:N-1];                       % n的行向量
k = [0:1:N-1];                       % k的行向量
WN = exp(-j*2*pi/N);                 % Wn 因子
nk = n'*k;                           % 产生一个含nk值的N 乘 N维矩阵
WNnk = WN .^ nk;                     % DFT 矩阵
Xk = xn * WNnk;                      % DFT 系数的行向量

