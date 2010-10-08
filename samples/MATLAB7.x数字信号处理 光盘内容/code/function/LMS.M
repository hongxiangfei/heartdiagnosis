function [h,y] = lms(x,d,delta,N)
%ϵ��������LMS�㷨
% ----------------------------------------
%  [h,y] = lms(x,d,delta,N)
%     h = ���Ƶ� FIR �˲���
%     y = ������� y(n)
%     x = �������� x(n)
%     d = Ԥ������ d(n), �䳤��Ӧ�� x ��ͬ
%  delta = ����
%     N =  FIR�˲����ĳ���
%
M = length(x); y = zeros(1,M);
h = zeros(1,N);
for n = N:M
    x1 = x(n:-1:n-N+1);
     y = h * x1';
     e = d(n) - y;
     h = h + delta*e*x1;
end
