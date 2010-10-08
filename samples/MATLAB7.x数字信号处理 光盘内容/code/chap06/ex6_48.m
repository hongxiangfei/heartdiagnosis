randn('state', 1);
n = 0:99;
s = sin(pi/3*n) + 2*sin(pi/4*n) + randn(1, 100);
X = corrmtx(s, 7, 'mod');   % 使用改进的协方差法估计互相关矩阵
[s, w, V, E] = peig(X, 4, 'whole');
peig(X, 4, 'whole');
