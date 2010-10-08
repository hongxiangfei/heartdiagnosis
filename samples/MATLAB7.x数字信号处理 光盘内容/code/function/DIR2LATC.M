function [K] = dir2latc(b)
% FIR的直接型式到全零格形的型式转换
% ---------------------------------------------------
% [K] = dir2latc(b)
%  K = 格形滤波器系数(反射系数) 
%  b = 直接型式的多项式系数(脉冲响应)
%
M = length(b);
K = zeros(1,M);
b1 = b(1);
if b1 == 0
	error('b(1) 等于零')
end
K(1) = b1; A = b/b1;
for m=M:-1:2
	K(m) = A(m);
	J = fliplr(A);
	A = (A-K(m)*J)/(1-K(m)*K(m));
	A = A(1:m-1);
end
