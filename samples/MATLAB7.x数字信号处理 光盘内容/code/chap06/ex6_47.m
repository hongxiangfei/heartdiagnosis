randn('state', 1);
n = 0:99;
s = exp(i*pi/2*n) + 2*exp(i*pi/4*n) + exp(i*pi/3*n) + randn(1, 100);
X = corrmtx(s, 7, 'mod')  % ʹ�øĽ���Э������ƻ���ؾ���
[s, w, V, E] = pmusic(X, 4, 'whole');
pmusic(X, 4, 'whole');
