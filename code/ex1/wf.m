function w = wf(f)

u = 55;
k = 25;

w = exp(-exp(-(f-u)./k)-(f-u)./k+1);