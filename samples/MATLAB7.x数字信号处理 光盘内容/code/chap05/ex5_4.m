subplot(1,1,1)
h = [-4,1,-1,-2,5,6,-6,-5,2,1,-1,4];
M = length(h); n = 0:M-1;
[Hr,w,d,L] = Hr_Type4(h);
dmax = max(d)+1; dmin = min(d)-1;
subplot(2,2,1); stem(n,h); axis([-1 2*L+1 dmin dmax])
text(2*L+1.5,dmin,'n'); ylabel('h(n)'); title('脉冲响应')
subplot(2,2,3); stem(1:L,d); axis([-1 2*L+1 dmin dmax])
text(2*L+1.5,dmin,'n'); ylabel('d(n)'); title('d(n) 系数')
subplot(2,2,2);plot(w/pi,Hr);grid
text(1.05,-10,'频率pi'); ylabel('Hr')
title('4-型振幅响应')
subplot(2,2,4);pzplotz(h,1);
title('零极点分布')

