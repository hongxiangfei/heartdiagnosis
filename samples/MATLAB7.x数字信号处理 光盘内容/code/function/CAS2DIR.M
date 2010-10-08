function [b,a] = cas2dir(b0,B,A);
% 级联型到直接型的型式转换
% ---------------------------------
% [b,a] = cas2dir(b0,B,A)
%  b = 直接型的分子多项式系数
%  a = 直接型的分母多项式系数
% b0 = 增益系数
%  B = 包含各bk的K乘3维实系数矩阵
%  A = 包含各ak的K乘3维实系数矩阵
%
[K,L] = size(B);
b = [1];
a = [1];
for i=1:1:K
	b=conv(b,B(i,:));
	a=conv(a,A(i,:));
end
b = b*b0;
