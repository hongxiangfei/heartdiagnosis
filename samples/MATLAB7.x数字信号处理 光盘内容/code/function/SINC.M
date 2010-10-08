function y=sinc(x)
% º¯Êý y=sinc(x)=sin(pi*x)./(pi*x)
% -----------------------
x = x + eps;
y = sin(pi*x) ./ (pi*x);
