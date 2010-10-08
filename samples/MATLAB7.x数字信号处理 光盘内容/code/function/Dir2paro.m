function [C,B,A] = dir2par(b,a);
% 直接型到并联型的转换
% --------------------------------------
% [C,B,A] = dir2par(b,a)
%  C = 当length(b) >= length(a)时的多项式部分
%  B = 包含各bk的K乘2维实系数矩阵
%  A = 包含各ak的K乘3维实系数矩阵
%  b = 直接型的分子多项式系数
%  a = 直接型的分母多项式系数
%
M = length(b); N = length(a);

[r1,p1,C] = residuez(b,a);
p = cplxpair(p1,10000000*eps);
I = cplxcomp(p1,p);
r = r1(I);

K = floor(N/2); B = zeros(K,2); A = zeros(K,3);
if K*2 == N; %N 为偶, A(z) 的次数为奇,有一个因子是一阶的 
	for i=1:2:N-2
		Brow = r(i:1:i+1,:);
		Arow = p(i:1:i+1,:);
		[Brow,Arow] = residuez(Brow,Arow,[]);
		B(fix((i+1)/2),:) = real(Brow');
		A(fix((i+1)/2),:) = real(Arow');
	end
	[Brow,Arow] = residuez(r(N-1),p(N-1),[]);
	B(K,:) = [real(Brow') 0]; A(K,:) = [real(Arow') 0];
else
        for i=1:2:N-1
		Brow = r(i:1:i+1,:);
		Arow = p(i:1:i+1,:);
		[Brow,Arow] = residuez(Brow,Arow,[]);
		B(fix((i+1)/2),:) = real(Brow');
		A(fix((i+1)/2),:) = real(Arow');
	end     
end
