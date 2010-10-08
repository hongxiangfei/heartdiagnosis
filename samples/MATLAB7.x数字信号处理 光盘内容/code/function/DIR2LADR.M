function [K,C] = dir2ladr(b,a)
% 直接型到极点-零点格/梯型的型式转换
% -----------------------------------------------------------
% [K,C] = dir2ladr(b,a)
%  K = 格型系数(反射系数), [K1,...,KN]
%  C = 梯型系数, [C0,...,CN]
%  b = 直接型的分子多项式系数 (deg <= Num deg)
%  a = 直接型的分母多项式系数
%
a1 = a(1); a = a/a1; b = b/a1;
M = length(b); N = length(a);
if M > N
     error('   *** b的长度必须 <= a 的长度***')
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
