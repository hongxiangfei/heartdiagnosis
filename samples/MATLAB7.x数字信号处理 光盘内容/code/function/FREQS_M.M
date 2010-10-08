function [db,mag,pha,w] = freqs_m(b,a,wmax);
% s域频率响应计算的改进版本- 
% ------------------------------------------------------------
% [db,mag,pha,w] = freqs_m(b,a,wmax);
%   db = [0 to wmax]区间内的相对振幅
%  mag = [0 to wmax]区间内的绝对振幅
%  pha = [0 to wmax] 区间内的相位响应
%    w = [0 to wmax]区间内的500个频率样本向量
%    b = Ha(s)的分子多项式系数
%    a = Ha(s)的分母多项式系数
% wmax = 希望获得响应的频率区间的最大频率
%
w = [0:1:500]*wmax/500;
H = freqs(b,a,w);
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
pha = angle(H);
