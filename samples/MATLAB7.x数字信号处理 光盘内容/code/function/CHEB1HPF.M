function [b,a] = cheb1hpf(wp,ws,Rp,As)
% ���б�ѩ��-1Ϊԭ�����IIR ��ͨ�˲���
% [b,a] = cheb1hpf(wp,ws,Rp,As)
%   b = ��ͨ�˲����ķ��Ӷ���ʽ
%   a = ��ͨ�˲����ķ�ĸ����ʽ
%  wp = �Ի���/��Ϊ��λ��ͨ��Ƶ��
%  ws = �Ի���/��Ϊ��λ�����Ƶ��; 
%  Rp = ͨ���е����������+dB��; (Rp > 0)
%  As = ���˥����+dB��; (As > 0)
%
% ������ֵ�ͨ��ֹƵ��:
wplp = 0.2*pi;
alpha = -(cos((wplp+wp)/2))/(cos((wplp-wp)/2));
wslp = angle(-(exp(-j*ws)+alpha)/(1+alpha*exp(-j*ws)));
%
% ���ģ���ͨԭ��ָ��:
T = 1; Fs = 1/T;
OmegaP = (2/T)*tan(wplp/2);
OmegaS = (2/T)*tan(wslp/2);

% ���ģ���б�ѩ��ԭ�͵�ͨ�˲���.:
[cs,ds] = afd_chb1(OmegaP,OmegaS,Rp,As);

% ʵ��˫���Ա任�Եõ����ֵ�ͨ:
[blp,alp] = bilinear(cs,ds,Fs);

% �����ֵ�ͨ�任Ϊ��ͨ�˲���:
Nz = -[alpha,1]; Dz = [1,alpha];
[b,a] = zmapping(blp,alp,Nz,Dz);
