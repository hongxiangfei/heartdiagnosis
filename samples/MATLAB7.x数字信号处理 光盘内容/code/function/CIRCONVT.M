function y = circonvt(x1,x2,N)
% ��x1 �� x2: (ʱ��)֮���N��Բ�ܾ��
% -------------------------------------------------------------
% [y] = circonvt(x1,x2,N)
%  y = ����Բ�ܾ�����������
% x1 = ���� N1 <= N ����������
% x2 =  ���� N2 <= N ����������
%  N = Բ�ܻ������Ĵ�С
%  ���� y(n) = sum (x1(m)*x2((n-m) mod N))

% Check for length of x1
if length(x1) > N
        error('N ���� >= x1�ĳ���')
end

% Check for length of x2
if length(x2) > N
        error('N ���� >= x2�ĳ���')
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
