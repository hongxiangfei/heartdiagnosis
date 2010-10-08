function [b,a] = cheb1hpf(wp,ws,Rp,As)
% 用切比雪夫-1为原型设计IIR 高通滤波器
% [b,a] = cheb1hpf(wp,ws,Rp,As)
%   b = 高通滤波器的分子多项式
%   a = 高通滤波器的分母多项式
%  wp = 以弧度/秒为单位的通带频率
%  ws = 以弧度/秒为单位的阻带频率; 
%  Rp = 通带中的振幅波动的+dB数; (Rp > 0)
%  As = 阻带衰减的+dB数; (As > 0)
%
% 求出数字低通截止频率:
wplp = 0.2*pi;
alpha = -(cos((wplp+wp)/2))/(cos((wplp-wp)/2));
wslp = angle(-(exp(-j*ws)+alpha)/(1+alpha*exp(-j*ws)));
%
% 求出模拟低通原型指标:
T = 1; Fs = 1/T;
OmegaP = (2/T)*tan(wplp/2);
OmegaS = (2/T)*tan(wslp/2);

% 设计模拟切比雪夫原型低通滤波器.:
[cs,ds] = afd_chb1(OmegaP,OmegaS,Rp,As);

% 实行双线性变换以得到数字低通:
[blp,alp] = bilinear(cs,ds,Fs);

% 将数字低通变换为高通滤波器:
Nz = -[alpha,1]; Dz = [1,alpha];
[b,a] = zmapping(blp,alp,Nz,Dz);
