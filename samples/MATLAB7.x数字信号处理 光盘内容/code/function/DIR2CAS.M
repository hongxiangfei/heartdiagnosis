function [b0,B,A] = dir2cas(b,a);
% 直接型到级联型的型式转换(复数对型)
% ---------------------------------------------------------
% [b0,B,A] = dir2cas(b,a)
%  b = 直接型的分子多项式系数
%  a = 直接型的分母多项式系数
% b0 = 增益系数
%  B = 包含各bk的K乘3维实系数矩阵
%  A = 包含各ak的K乘3维实系数矩阵

% compute gain coefficient b0
b0 = b(1); b = b/b0;
a0 = a(1); a = a/a0;
b0 = b0/a0;
%
M = length(b); N = length(a);
if N > M
	b = [b zeros(1,N-M)];
elseif M > N
	a = [a zeros(1,M-N)]; N = M;
else
	NM = 0;
end
%
K = floor(N/2); B = zeros(K,3); A = zeros(K,3);
if K*2 == N;
	b = [b 0];
	a = [a 0];
end
%        
broots = cplxpair(roots(b));
aroots = cplxpair(roots(a));
for i=1:2:2*K
	Brow = broots(i:1:i+1,:);
	Brow = real(poly(Brow));
	B(fix((i+1)/2),:) = Brow;
	Arow = aroots(i:1:i+1,:);
	Arow = real(poly(Arow));
	A(fix((i+1)/2),:) = Arow;
end     
