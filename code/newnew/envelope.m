function y=envelope(x)
 
% 解析信号
x = abs(hilbert(x));
% 信号长度
n = length(x);
% 极大值点的index
max = find(diff(sign(diff(x)))==-2)+1;
% 插值操作
y = interp1(max,x(max),1:n,'cubic');


