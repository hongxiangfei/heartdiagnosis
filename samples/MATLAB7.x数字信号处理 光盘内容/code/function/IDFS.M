function [xn] = idfs(Xk,N)
% 计算逆离散付利叶级数(IDFS) 
% ----------------------------------------
% [xn] = idfs(Xk,N)
% xn = 周期信号在 0 <= n <= N-1之间的一个单周期信号
% Xk = 在0 <= k <= N-1间的DFS 系数数组 
%  N = Xk 的基本周期
%
n = [0:1:N-1];                       % n的行向量
k = [0:1:N-1];                       % k 的行向量
WN = exp(-j*2*pi/N);                 % Wn 因子
nk = n'*k;                           % 产生一个含nk值的N 乘 N维矩阵
WNnk = WN .^ (-nk);                  % IDFS 矩阵
xn = (Xk * WNnk)/N;                  % IDFS 值的行向量
