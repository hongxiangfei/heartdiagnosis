function [b,a] = u_chb2ap(N,As,Omegac);
% δ��һ�����б�ѩ��-2��ģ���ͨ�˲���ԭ��
% --------------------------------------------------------
% [b,a] = u_chb2ap(N,As,Omegac);
%   b = Ha(s) ���Ӷ���ʽ��ϵ��
%   a = Ha(s) ��ĸ����ʽ��ϵ��
%   N=�˲����Ľ��� 
%   As = �������dB��; As > 0
% Omegac = �Ի���/��Ľ�ֹƵ��
%
[z,p,k] = cheb2ap(N,As);
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
