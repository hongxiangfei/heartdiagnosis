function [xec, xoc] = circevod(x)
% 将信号分解为圆周偶和圆周奇两部分
% --------------------------------------------------------------
% [xec, xoc] = circecod(x)
%
if any(imag(x) ~= 0)
      error('x 非实数序列')
end
N = length(x); n = 0:(N-1);
xec = 0.5*(x + x(mod(-n,N)+1));
xoc = 0.5*(x - x(mod(-n,N)+1));
