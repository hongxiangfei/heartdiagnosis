function [yq] = quantize(y,B)
% 将信号量化为B位
% -------------------------
% [yq] = quantize(y,B)
%    yq = 量化后的信号(整数): 0 <= yq <= 2^B-1
%     y = 输入信号
%     B = 位数/样本
%
swing = (2^B-1)/2;
yq = round(y*swing+swing);
