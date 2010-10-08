function [y,n] = sigshift(x,m,n0)
% й╣ож y(n) = x(n-n0)
% -------------------------
% [y,n] = sigshift(x,m,n0)
%
n = m+n0; y = x;
