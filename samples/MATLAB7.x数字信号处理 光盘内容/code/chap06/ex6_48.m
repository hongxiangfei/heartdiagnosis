randn('state', 1);
n = 0:99;
s = sin(pi/3*n) + 2*sin(pi/4*n) + randn(1, 100);
X = corrmtx(s, 7, 'mod');   % ʹ�øĽ���Э������ƻ���ؾ���
[s, w, V, E] = peig(X, 4, 'whole');
peig(X, 4, 'whole');
