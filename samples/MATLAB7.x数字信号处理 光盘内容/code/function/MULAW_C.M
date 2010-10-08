function [y] = mulaw_c(s,mu)
% mu-���ɵ�ѹ����
% -----------------
% [y] = mulaw_c(s,mu)
%  y = ѹ���˵�����ź�
%  s = -1 �� 1֮������ֵ��һ���ź�
% mu = ���� mu
%
if mu == 0 
   y = s;
else
   y = (log(1+mu*abs(s))/(log(1+mu))).*sign(s);
end
