function hd = ideal_lp(wc,M);
% 理想低通滤波器计算
% --------------------------------
% [hd] = ideal_lp(wc,M)
%  hd = 0 to M-1之间的理想脉冲响应
%  wc = 截止频率(弧度) 
%   M = 理想滤波器的长度
%
alpha = (M-1)/2;
n = [0:1:(M-1)];
m = n - alpha + eps;
hd = sin(wc*m) ./ (pi*m);

