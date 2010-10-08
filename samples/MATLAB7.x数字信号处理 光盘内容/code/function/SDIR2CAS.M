function [C,B,A] = sdir2cas(b,a);
% sƽ����ֱ���͵������͵���ʽת��(��������)
% -------------------------------------------------
% [C,B,A] = sdir2cas(b,a)
%  C = ����ϵ��
%  B = ������bk��K��3άʵϵ������
%  A = ������ak��K��3άʵϵ������
%  b = ֱ���͵ķ��Ӷ���ʽϵ��
%  a = ֱ���͵ķ�ĸ����ʽϵ��
%
Na = length(a)-1; Nb = length(b)-1;

% ��������ϵ�� C
b0 = b(1); b = b/b0;
a0 = a(1); a = a/a0;
 C = b0/a0;
%
%:
p= cplxpair(roots(a)); K = floor(Na/2);
if K*2 == Na     % ��NaΪżʱ����
   A = zeros(K,3);
   for n=1:2:Na
       Arow = p(n:1:n+1,:);
       Arow = poly(Arow);
       A(fix((n+1)/2),:) = real(Arow);
   end

elseif Na == 1   % �� Na = 1 ʱ����
       A = [0 real(poly(p))];

else             % �� Na Ϊ�漰 > 1ʱ����
   A = zeros(K+1,3);
   for n=1:2:2*K
       Arow = p(n:1:n+1,:);
       Arow = poly(Arow);
       A(fix((n+1)/2),:) = real(Arow);
       end
       A(K+1,:) = [0 real(poly(p(Na)))];
end

% ���ӵĶ������Ӳ���:
z = cplxpair(roots(b)); K = floor(Nb/2);
if Nb == 0           % �� Nb = 0 ʱ����
   B = [0 0 poly(z)];

elseif K*2 == Nb     % �� Nb Ϊżʱ����
   B = zeros(K,3);
   for n=1:2:Nb
       Brow = z(n:1:n+1,:);
       Brow = poly(Brow);
       B(fix((n+1)/2),:) = real(Brow);
   end

elseif Nb == 1       % �� Nb = 1 ʱ����
       B = [0 real(poly(z))];

else                 % �� Nb Ϊ���� > 1ʱ����
   B = zeros(K+1,3);
   for n=1:2:2*K
       Brow = z(n:1:n+1,:);
       Brow = poly(Brow);
       B(fix((n+1)/2),:) = real(Brow);
   end
   B(K+1,:) = [0 real(poly(z(Nb)))];
end


