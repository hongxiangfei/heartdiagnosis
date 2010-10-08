function [Rp,As] = delta2db(delta1,delta2)
%  从绝对delta 标度变换为相对dB标度. 
% ---------------------------------------------------------
% [Rp,As] = delta2db(delta1,delta2)
% [d1,d2] = db2delta(Rp,As)
% Rp = 通带波动
% As = 阻带衰减
% d1 = 通带容差
% d2 = 阻带容差
%
Rp = -20*log10((1-delta1)/(1+delta1));
As = -20*log10(delta2/(1+delta1));
