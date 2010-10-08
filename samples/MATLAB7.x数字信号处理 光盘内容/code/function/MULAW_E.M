function [sq] = mulaw_e(yq,B,mu)
% mu-���ɵĽ�ѹ��
% ---------------
% [sq] = mulaw_e(yq,B,mu)
%  sq = ��ѹ�������ź�
% yq =�����˵�����(����): 0 <=yq <= 2^B-1
%  B = λ��/����
% mu = ���� mu
%
swing = (2^B-1)/2;
yq = ((yq-swing)/swing);
if mu == 0
  sq = yq;
else
  sq = (((1+mu).^(abs(yq))-1)/mu).*sign(yq);
end
