function [Rp,As] = delta2db(delta1,delta2)
%  �Ӿ���delta ��ȱ任Ϊ���dB���. 
% ---------------------------------------------------------
% [Rp,As] = delta2db(delta1,delta2)
% [d1,d2] = db2delta(Rp,As)
% Rp = ͨ������
% As = ���˥��
% d1 = ͨ���ݲ�
% d2 = ����ݲ�
%
Rp = -20*log10((1-delta1)/(1+delta1));
As = -20*log10(delta2/(1+delta1));
