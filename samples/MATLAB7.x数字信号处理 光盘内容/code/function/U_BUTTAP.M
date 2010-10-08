function [b,a] = u_buttap(N,Omegac);
% δ��һ���İ�����˹ģ���ͨ�˲���ԭ��
% --------------------------------------------------------
% [b,a] = u_buttap(N,Omegac);
%   b = Ha(s) ���Ӷ���ʽ��ϵ��
%   a = Ha(s) ��ĸ����ʽ��ϵ��
%   N=�˲����Ľ��� 
% Omegac = �Ի���/��Ľ�ֹƵ��
%
[z,p,k] = buttap(N);
      p = p*Omegac;
      k = k*Omegac^N;
      B = real(poly(z));
      b0 = k;
      b = k*B;
      a = real(poly(p));
