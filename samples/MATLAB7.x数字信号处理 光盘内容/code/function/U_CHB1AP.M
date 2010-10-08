function [b,a] = u_chb1ap(N,Rp,Omegac);
% δ��һ�����б�ѩ��-1��ģ���ͨ�˲���ԭ��
% --------------------------------------------------------
% [b,a] = u_chb1ap(N,Rp,Omegac);
%   b = Ha(s) ���Ӷ���ʽ��ϵ��
%   a = Ha(s) ��ĸ����ʽ��ϵ��
%   N=�˲����Ľ��� 
%   Rp = ͨ������ dB��; Rp > 0
% Omegac = �Ի���/��Ľ�ֹƵ��
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
