function hd = ideal_lp(wc,M);
% �����ͨ�˲�������
% --------------------------------
% [hd] = ideal_lp(wc,M)
%  hd = 0 to M-1֮�������������Ӧ
%  wc = ��ֹƵ��(����) 
%   M = �����˲����ĳ���
%
alpha = (M-1)/2;
n = [0:1:(M-1)];
m = n - alpha + eps;
hd = sin(wc*m) ./ (pi*m);

