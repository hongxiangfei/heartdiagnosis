function y=sinc(x)
% ���� y=sinc(x)=sin(pi*x)./(pi*x)
% -----------------------
x = x + eps;
y = sin(pi*x) ./ (pi*x);
