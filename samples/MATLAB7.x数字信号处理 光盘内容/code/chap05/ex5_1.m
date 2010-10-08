
subplot(1,1,1)
h = [-4,1,-1,-2,5,6,5,-2,-1,1,-4];
M = length(h); n = 0:M-1;
[Hr,w,a,L] = Hr_Type1(h);
amax = max(a)+1; amin = min(a)-1;
subplot(2,2,1); stem(n,h); axis([-1 2*L+1 amin amax])
text(2*L+1.5,amin,'n'); ylabel('h(n)'); title('������Ӧ')
subplot(2,2,3); stem(0:L,a); axis([-1 2*L+1 amin amax])
xlabel('n'); ylabel('a(n)'); title('a(n) ϵ��')
subplot(2,2,2);plot(w/pi,Hr);grid
text(1.05,-20,'Ƶ��pi'); ylabel('Hr')
title('1-�������Ӧ')
subplot(2,2,4);pzplotz(h,1)
title('�㼫��ֲ�')
