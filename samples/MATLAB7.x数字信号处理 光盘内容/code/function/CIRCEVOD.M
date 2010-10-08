function [xec, xoc] = circevod(x)
% ���źŷֽ�ΪԲ��ż��Բ����������
% --------------------------------------------------------------
% [xec, xoc] = circecod(x)
%
if any(imag(x) ~= 0)
      error('x ��ʵ������')
end
N = length(x); n = 0:(N-1);
xec = 0.5*(x + x(mod(-n,N)+1));
xoc = 0.5*(x - x(mod(-n,N)+1));
