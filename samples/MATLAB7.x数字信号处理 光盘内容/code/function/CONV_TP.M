function [y,H]=conv_tp(h,x)
% ��Toeplitz ��������Ծ��
% ----------------------------------------
% [y,H] = conv_tp(h,x)
% y = ��������ʽ���������o 
% H = ��Ӧ������h��Toeplitz ����,���y = Hx
% h = ��������ʽ��������Ӧ����
% x = ��������ʽ���������� 
%
Nx = length(x); Nh = length(h);
hc=[h; zeros(Nx-1, 1)];
hr=[h(1),zeros(1,Nx-1)];
H=toeplitz(hc,hr);
y=H*x;
