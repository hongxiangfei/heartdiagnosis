function y = cirshftt(x,m,N)
% 长度为 N 的x序列: (时域)作m采样点圆周移位
% -------------------------------------------------------------------
% [y] = cirshftt(x,m,N)
% y = 包含圆周移位的输出序列
% x = 长度 <= N的输入序列
% m = 移位采样数 
% N = 圆周缓冲器长度 
% 方法: y(n) = x((n-m) mod N)

% Check for length of x
if length(x) > N
        error('N 必须 >= x的长度')
end
x = [x zeros(1,N-length(x))];
n = [0:1:N-1];
n = mod(n-m,N);
y = x(n+1);
