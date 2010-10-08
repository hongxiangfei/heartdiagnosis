function [y,H]=conv_tp(h,x)
% 用Toeplitz 矩阵的线性卷积
% ----------------------------------------
% [y,H] = conv_tp(h,x)
% y = 列向量形式的输出序列o 
% H = 对应于序列h的Toeplitz 矩阵,因而y = Hx
% h = 列向量形式的脉冲响应序列
% x = 列向量形式的输入序列 
%
Nx = length(x); Nh = length(h);
hc=[h; zeros(Nx-1, 1)];
hr=[h(1),zeros(1,Nx-1)];
H=toeplitz(hc,hr);
y=H*x;
