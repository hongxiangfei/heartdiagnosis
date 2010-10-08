function [sq] = mulaw_e(yq,B,mu)
% mu-定律的解压器
% ---------------
% [sq] = mulaw_e(yq,B,mu)
%  sq = 解压后的输出信号
% yq =量化了的输入(整数): 0 <=yq <= 2^B-1
%  B = 位数/样本
% mu = 参数 mu
%
swing = (2^B-1)/2;
yq = ((yq-swing)/swing);
if mu == 0
  sq = yq;
else
  sq = (((1+mu).^(abs(yq))-1)/mu).*sign(yq);
end
