function [C,B,A] = sdir2cas(b,a);
% s平面中直接型到级联型的型式转换(复数对型)
% -------------------------------------------------
% [C,B,A] = sdir2cas(b,a)
%  C = 增益系数
%  B = 包含各bk的K乘3维实系数矩阵
%  A = 包含各ak的K乘3维实系数矩阵
%  b = 直接型的分子多项式系数
%  a = 直接型的分母多项式系数
%
Na = length(a)-1; Nb = length(b)-1;

% 计算增益系数 C
b0 = b(1); b = b/b0;
a0 = a(1); a = a/a0;
 C = b0/a0;
%
%:
p= cplxpair(roots(a)); K = floor(Na/2);
if K*2 == Na     % 当Na为偶时计算
   A = zeros(K,3);
   for n=1:2:Na
       Arow = p(n:1:n+1,:);
       Arow = poly(Arow);
       A(fix((n+1)/2),:) = real(Arow);
   end

elseif Na == 1   % 当 Na = 1 时计算
       A = [0 real(poly(p))];

else             % 当 Na 为奇及 > 1时计算
   A = zeros(K+1,3);
   for n=1:2:2*K
       Arow = p(n:1:n+1,:);
       Arow = poly(Arow);
       A(fix((n+1)/2),:) = real(Arow);
       end
       A(K+1,:) = [0 real(poly(p(Na)))];
end

% 分子的二阶因子部分:
z = cplxpair(roots(b)); K = floor(Nb/2);
if Nb == 0           % 当 Nb = 0 时计算
   B = [0 0 poly(z)];

elseif K*2 == Nb     % 当 Nb 为偶时计算
   B = zeros(K,3);
   for n=1:2:Nb
       Brow = z(n:1:n+1,:);
       Brow = poly(Brow);
       B(fix((n+1)/2),:) = real(Brow);
   end

elseif Nb == 1       % 当 Nb = 1 时计算
       B = [0 real(poly(z))];

else                 % 当 Nb 为奇且 > 1时计算
   B = zeros(K+1,3);
   for n=1:2:2*K
       Brow = z(n:1:n+1,:);
       Brow = poly(Brow);
       B(fix((n+1)/2),:) = real(Brow);
   end
   B(K+1,:) = [0 real(poly(z(Nb)))];
end


