function y = cirshftt(x,m,N)
% ����Ϊ N ��x����: (ʱ��)��m������Բ����λ
% -------------------------------------------------------------------
% [y] = cirshftt(x,m,N)
% y = ����Բ����λ���������
% x = ���� <= N����������
% m = ��λ������ 
% N = Բ�ܻ��������� 
% ����: y(n) = x((n-m) mod N)

% Check for length of x
if length(x) > N
        error('N ���� >= x�ĳ���')
end
x = [x zeros(1,N-length(x))];
n = [0:1:N-1];
n = mod(n-m,N);
y = x(n+1);
