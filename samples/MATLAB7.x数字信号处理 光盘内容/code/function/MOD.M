function m = mod(n,N)
% ¼ÆËã m = (n mod N) ÏÂ±ê
% ----------------------------
% m = mod(n,N)
m = rem(n,N);
m = m+N;
m = rem(m,N);
