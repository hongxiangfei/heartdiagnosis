%
subplot(1,1,1)
h = [-4,1,-1,-2,5,0,-5,2,1,-1,4];
M = length(h); n = 0:M-1;
[Hr,w,c,L] = Hr_Type3(h);
cmax = max(c)+1; cmin = min(c)-1;
subplot(2,2,1); stem(n,h); axis([-1 2*L+1 cmin cmax])
text(2*L+1.5,cmin,'n'); ylabel('h(n)'); title('脉冲响应')
subplot(2,2,3); stem(0:L,c); axis([-1 2*L+1 cmin cmax])
xlabel('n'); ylabel('c(n)'); title('c(n) 系数')
subplot(2,2,2);plot(w/pi,Hr);grid
text(1.05,-10,'频率pi'); ylabel('Hr')
title('3-型振幅响应')
subplot(2,2,4);pzplotz(h,1);
title('零极点分布')


