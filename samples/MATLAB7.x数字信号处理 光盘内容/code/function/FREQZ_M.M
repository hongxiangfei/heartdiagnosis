function [db,mag,pha,grd,w] = freqz_m(b,a);
% freqz 子程序的改进版本
% ------------------------------------
% [db,mag,pha,grd,w] = freqz_m(b,a);
%   db = [0 到pi弧度]区间内的相对振幅(db)
%  mag = [0 到pi弧度]区间内的绝对振幅
%  pha = [0 到pi弧度]区间内的相位响应
%  grd = [0 到pi弧度]区间内的群迟延
%    w =  [0 到pi弧度]区间内的501个频率样本向量
%    b = Ha(z)的分子多项式系数(对FIR b=h)
%    a = Ha(z)的分母多项式系数(对 FIR: a=[1])
%
[H,w] = freqz(b,a,1000,'whole');
    H = (H(1:1:501))'; w = (w(1:1:501))';
  mag = abs(H);
   db = 20*log10((mag+eps)/max(mag));
  pha = angle(H);
%  pha = unwrap(angle(H));
  grd = grpdelay(b,a,w);
%  grd = diff(pha);
%  grd = [grd(1) grd];
%  grd = [0 grd(1:1:500); grd; grd(2:1:501) 0];
%  grd = median(grd)*500/pi;

