function [b,a] = u_elipap(N,Rp,As,Omegac);
% 未归一化的椭圆型模拟低通滤波器原型
% -----------------------------------------------------
% [b,a] = u_elipap(N,Rp,As,Omegac);
%   b = Ha(s) 分子多项式的系数
%   a = Ha(s) 分母多项式的系数
%   N=滤波器的阶数 
%   Rp = 通带波动dB数; Rp > 0
%   As = 阻带波动 dB数; As > 0
% Omegac = 以弧度/秒的截止频率
%
[z,p,k] = ellipap(N,Rp,As);
      a = real(poly(p));
    aNn = a(N+1);
      p = p*Omegac;
      a = real(poly(p));
    aNu = a(N+1);  
      b = real(poly(z));
      M = length(b);
    bNn = b(M);  
      z = z*Omegac;
      b = real(poly(z));
    bNu = b(M);
      k = k*(aNu*bNn)/(aNn*bNu);
     b0 = k;
      b = k*b;
