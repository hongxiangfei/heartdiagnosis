function [h,y] = lms(x,d,delta,N)
%系数调整的LMS算法
% ----------------------------------------
%  [h,y] = lms(x,d,delta,N)
%     h = 估计的 FIR 滤波器
%     y = 输出数组 y(n)
%     x = 输入数组 x(n)
%     d = 预期数组 d(n), 其长度应与 x 相同
%  delta = 步长
%     N =  FIR滤波器的长度
%
M = length(x); y = zeros(1,M);
h = zeros(1,N);
for n = N:M
    x1 = x(n:-1:n-N+1);
     y = h * x1';
     e = d(n) - y;
     h = h + delta*e*x1;
end
