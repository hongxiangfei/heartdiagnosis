function [yq] = quantize(y,B)
% ���ź�����ΪBλ
% -------------------------
% [yq] = quantize(y,B)
%    yq = ��������ź�(����): 0 <= yq <= 2^B-1
%     y = �����ź�
%     B = λ��/����
%
swing = (2^B-1)/2;
yq = round(y*swing+swing);
