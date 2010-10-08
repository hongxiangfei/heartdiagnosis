function [b,a] = u_chb1ap(N,Rp,Omegac);
% 未归一化的切比雪夫-1型模拟低通滤波器原型
% --------------------------------------------------------
% [b,a] = u_chb1ap(N,Rp,Omegac);
%   b = Ha(s) 分子多项式的系数
%   a = Ha(s) 分母多项式的系数
%   N=滤波器的阶数 
%   Rp = 通带波动 dB数; Rp > 0
% Omegac = 以弧度/秒的截止频率
%
[z,p,k] = cheb1ap(N,Rp);
      a = real(poly(p));
    aNn = a(N+1);
      p = p*Omegac;
      a = real(poly(p));
    aNu = a(N+1);  
      k = k*aNu/aNn;
      b0 = k;
      B = real(poly(z));
      b = k*B;
