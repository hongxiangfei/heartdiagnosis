function [b,a] = u_buttap(N,Omegac);
% 未归一化的巴特沃斯模拟低通滤波器原型
% --------------------------------------------------------
% [b,a] = u_buttap(N,Omegac);
%   b = Ha(s) 分子多项式的系数
%   a = Ha(s) 分母多项式的系数
%   N=滤波器的阶数 
% Omegac = 以弧度/秒的截止频率
%
[z,p,k] = buttap(N);
      p = p*Omegac;
      k = k*Omegac^N;
      B = real(poly(z));
      b0 = k;
      b = k*B;
      a = real(poly(p));
