function y=envelope(x)
 
% �����ź�
x = abs(hilbert(x));
% �źų���
n = length(x);
% ����ֵ���index
max = find(diff(sign(diff(x)))==-2)+1;
% ��ֵ����
y = interp1(max,x(max),1:n,'cubic');


