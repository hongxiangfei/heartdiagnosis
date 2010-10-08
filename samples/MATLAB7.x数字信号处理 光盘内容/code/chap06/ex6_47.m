randn('state', 1);
n = 0:99;
s = exp(i*pi/2*n) + 2*exp(i*pi/4*n) + exp(i*pi/3*n) + randn(1, 100);
X = corrmtx(s, 7, 'mod')  % 使用改进的协方差法估计互相关矩阵
[s, w, V, E] = pmusic(X, 4, 'whole');
pmusic(X, 4, 'whole');
