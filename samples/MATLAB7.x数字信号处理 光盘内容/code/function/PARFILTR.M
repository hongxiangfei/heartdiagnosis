function y = parfiltr(C,B,A,x);
%  IIR 滤波器的并行型实现
% ----------------------------------------
%  [y] = parfiltr(C,B,A,x);
%  y = 输出序列
%  C =当 M >= N时(FIR) 的多项式部分
%  B = 包含各bk的K乘2维实系数矩阵
%  A = 包含各ak的K乘3维实系数矩阵
%  x = 输入序列
%
[K,L] = size(B);
N = length(x);
w = zeros(K+1,N);
w(1,:) = filter(C,1,x);
for i = 1:1:K
        w(i+1,:) = filter(B(i,:),A(i,:),x);
end
y = sum(w);

