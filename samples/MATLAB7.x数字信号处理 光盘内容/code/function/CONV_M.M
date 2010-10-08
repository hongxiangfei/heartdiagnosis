function [y,ny] = conv_m(x,nx,h,nh)
% 信号处理的改进卷积程序
% --------------------------------------------------
% [y,ny] = conv_m(x,nx,h,nh)
%  y = 卷积结果
% ny = y 的基底(support)
%  x =基底 nx 上的第一个信号
% nx = x 的支架
%  h =基底 nh上的第二个信号
% nh = h 的基底
%
nyb = nx(1)+nh(1); nye = nx(length(x)) + nh(length(h));
ny = [nyb:nye];
y = conv(x,h);
