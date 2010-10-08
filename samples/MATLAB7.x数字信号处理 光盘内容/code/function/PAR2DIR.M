function [b,a] = par2dir(C,B,A);
% 并联型到直接型的转换
% ----------------------------------
% [b,a] = par2dir(C,B,A)
%  b = 直接型的分子多项式系数
%  a = 直接型的分母多项式系数
%  C = 并行型的多项式部分
%  B = 包含各bk的K乘2维实系数矩阵
%  A = 包含各ak的K乘3维实系数矩阵
%
[K,L] = size(A); R = []; P = [];

for i=1:1:K
	[r,p,k]=residuez(B(i,:),A(i,:));
	R = [R;r]; P = [P;p];
end
[b,a] = residuez(R,P,C);
b = b(:)'; a = a(:)';
