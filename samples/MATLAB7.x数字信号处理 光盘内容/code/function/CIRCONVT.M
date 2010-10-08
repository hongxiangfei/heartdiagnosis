function y = circonvt(x1,x2,N)
% 在x1 和 x2: (时域)之间的N点圆周卷积
% -------------------------------------------------------------
% [y] = circonvt(x1,x2,N)
%  y = 包含圆周卷积的输出序列
% x1 = 长度 N1 <= N 的输入序列
% x2 =  长度 N2 <= N 的输入序列
%  N = 圆周缓冲器的大小
%  方法 y(n) = sum (x1(m)*x2((n-m) mod N))

% Check for length of x1
if length(x1) > N
        error('N 必须 >= x1的长度')
end

% Check for length of x2
if length(x2) > N
        error('N 必须 >= x2的长度')
end

x1=[x1 zeros(1,N-length(x1))];
x2=[x2 zeros(1,N-length(x2))];

m = [0:1:N-1];
x2 = x2(mod(-m,N)+1);
H = zeros(N,N);

for n = 1:1:N
	H(n,:) = cirshftt(x2,n-1,N);
end

y = x1*H';
