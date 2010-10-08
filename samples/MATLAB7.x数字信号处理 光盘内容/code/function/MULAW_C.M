function [y] = mulaw_c(s,mu)
% mu-定律的压缩器
% -----------------
% [y] = mulaw_c(s,mu)
%  y = 压缩了的输出信号
%  s = -1 和 1之间的零均值归一化信号
% mu = 参数 mu
%
if mu == 0 
   y = s;
else
   y = (log(1+mu*abs(s))/(log(1+mu))).*sign(s);
end
