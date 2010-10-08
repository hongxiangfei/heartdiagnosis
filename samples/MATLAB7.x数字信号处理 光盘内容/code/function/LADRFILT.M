function [y] = ladrfilt(K,C,x)
% LATTICE/LADDER ��ʽIIR�˲���ʵ��
% ----------------------------------------------
% [y] = ladrfilt(K,C,x)
% y = �������
% K = LATTICE (����)ϵ������
% C = LADDER ϵ������
% x = ��������
%
Nx = length(x); y = zeros(1,Nx);
N = length(C); f = zeros(N,Nx); g = zeros(N,Nx+1);
f(N,:) = x;
for n = 2:1:Nx+1
    for m = N:-1:2
        f(m-1,n-1) = f(m,n-1) - K(m-1)*g(m-1,n-1);
        g(m,n) = K(m-1)*f(m-1,n-1) + g(m-1,n-1);
    end
    g(1,n) = f(1,n-1);
end
y = C*g(:,2:Nx+1);
