function [db,mag,pha,w] = freqs_m(b,a,wmax);
% s��Ƶ����Ӧ����ĸĽ��汾- 
% ------------------------------------------------------------
% [db,mag,pha,w] = freqs_m(b,a,wmax);
%   db = [0 to wmax]�����ڵ�������
%  mag = [0 to wmax]�����ڵľ������
%  pha = [0 to wmax] �����ڵ���λ��Ӧ
%    w = [0 to wmax]�����ڵ�500��Ƶ����������
%    b = Ha(s)�ķ��Ӷ���ʽϵ��
%    a = Ha(s)�ķ�ĸ����ʽϵ��
% wmax = ϣ�������Ӧ��Ƶ����������Ƶ��
%
w = [0:1:500]*wmax/500;
H = freqs(b,a,w);
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
pha = angle(H);
