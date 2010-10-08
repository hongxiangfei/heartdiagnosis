function [K,C] = dir2ladr(b,a)
% ֱ���͵�����-����/���͵���ʽת��
% -----------------------------------------------------------
% [K,C] = dir2ladr(b,a)
%  K = ����ϵ��(����ϵ��), [K1,...,KN]
%  C = ����ϵ��, [C0,...,CN]
%  b = ֱ���͵ķ��Ӷ���ʽϵ�� (deg <= Num deg)
%  a = ֱ���͵ķ�ĸ����ʽϵ��
%
a1 = a(1); a = a/a1; b = b/a1;
M = length(b); N = length(a);
if M > N
     error('   *** b�ĳ��ȱ��� <= a �ĳ���***')
end
b = [b, zeros(1,N-M)]; K = zeros(1,N-1);
A = zeros(N-1,N-1); C = b;
for m = N-1:-1:1
     A(m,1:m) = -a(2:m+1)*C(m+1);
     K(m) = a(m+1);
     J = fliplr(a);
     a = (a-K(m)*J)/(1-K(m)*K(m));
     a = a(1:m);
     C(m) = b(m) + sum(diag(A(m:N-1,1:N-m)));
end
