function [y] = latcfilt(K,x)
% 滤波器的格型实现
% ---------------------------------------
%  y = latcfilt(K,x)
%   y = 输出序列
%   K = 格型滤波器(反射)系数数组
%   x = 输入序列
%
Nx = length(x)-1;
x = K(1)*x;
M = length(K)-1; K = K(2:M+1);
fg = [x; [0 x(1:Nx)]];
for m = 1:M
    fg = [1,K(m);K(m),1]*fg;
    fg(2,:) = [0 fg(2,1:Nx)];
end
y = fg(1,:);
