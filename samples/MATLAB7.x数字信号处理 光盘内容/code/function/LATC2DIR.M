function [b] = latc2dir(K)
% 全零格型到FIR的直接型式的型式转换
% ---------------------------------------------------
% [b] = latc2dir(K)
%  b = 直接型式的多项式系数(脉冲响应)
%  K = 格形滤波器系数(反射系数) 
%
M = length(K);
J = 1; A = 1;
for m=2:1:M
	A = [A,0]+conv([0,K(m)],J);
	J = fliplr(A);
end
b=A*K(1);
