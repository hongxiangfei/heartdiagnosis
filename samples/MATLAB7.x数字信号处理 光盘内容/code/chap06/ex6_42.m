fs = 1000;
t = 0:1/fs:1;
x = sin(2*pi*100*t) + 4*sin(2*pi*200*t) + sin(2*pi*400*t) + randn(size(t));
pyulear(x, 20, [], fs);
