function [y,ny] = conv_m(x,nx,h,nh)
% �źŴ���ĸĽ��������
% --------------------------------------------------
% [y,ny] = conv_m(x,nx,h,nh)
%  y = ������
% ny = y �Ļ���(support)
%  x =���� nx �ϵĵ�һ���ź�
% nx = x ��֧��
%  h =���� nh�ϵĵڶ����ź�
% nh = h �Ļ���
%
nyb = nx(1)+nh(1); nye = nx(length(x)) + nh(length(h));
ny = [nyb:nye];
y = conv(x,h);
