function y = parfiltr(C,B,A,x);
%  IIR �˲����Ĳ�����ʵ��
% ----------------------------------------
%  [y] = parfiltr(C,B,A,x);
%  y = �������
%  C =�� M >= Nʱ(FIR) �Ķ���ʽ����
%  B = ������bk��K��2άʵϵ������
%  A = ������ak��K��3άʵϵ������
%  x = ��������
%
[K,L] = size(B);
N = length(x);
w = zeros(K+1,N);
w(1,:) = filter(C,1,x);
for i = 1:1:K
        w(i+1,:) = filter(B(i,:),A(i,:),x);
end
y = sum(w);

