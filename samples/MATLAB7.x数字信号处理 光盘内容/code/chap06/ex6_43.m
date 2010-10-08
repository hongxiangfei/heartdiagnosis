randn('seed', 0); %#ok<*RAND>
a = [1 0.1 0.2 0.3 0.4 0.5 0.6];
x = impz(1, a, 20) + randn(20, 1)/20;
[A, E, K] = arburg(x, 5);
