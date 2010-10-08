function [b,a] = u_elipap(N,Rp,As,Omegac);
% δ��һ������Բ��ģ���ͨ�˲���ԭ��
% -----------------------------------------------------
% [b,a] = u_elipap(N,Rp,As,Omegac);
%   b = Ha(s) ���Ӷ���ʽ��ϵ��
%   a = Ha(s) ��ĸ����ʽ��ϵ��
%   N=�˲����Ľ��� 
%   Rp = ͨ������dB��; Rp > 0
%   As = ������� dB��; As > 0
% Omegac = �Ի���/��Ľ�ֹƵ��
%
[z,p,k] = ellipap(N,Rp,As);
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
