function [K] = dir2latc(b)
% FIR��ֱ����ʽ��ȫ����ε���ʽת��
% ---------------------------------------------------
% [K] = dir2latc(b)
%  K = �����˲���ϵ��(����ϵ��) 
%  b = ֱ����ʽ�Ķ���ʽϵ��(������Ӧ)
%
M = length(b);
K = zeros(1,M);
b1 = b(1);
if b1 == 0
	error('b(1) ������')
end
K(1) = b1; A = b/b1;
for m=M:-1:2
	K(m) = A(m);
	J = fliplr(A);
	A = (A-K(m)*J)/(1-K(m)*K(m));
	A = A(1:m-1);
end
