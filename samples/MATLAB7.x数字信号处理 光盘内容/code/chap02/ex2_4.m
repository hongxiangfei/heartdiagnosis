clear all
close all
clc
x1=[1,2,3,4,5];
x2=[1,2,3,4,5,4,3,2,1];
N=length(x1)+length(x2);
n=0:N-1;
n1=0:N-2;
n2=0:N-3;
y1=circonvt(x1,x2,N);
y2=circonvt(x1,x2,N-1);
y3=circonvt(x1,x2,N-2);
x1=[x1 zeros(1,N-length(x1))];
x2=[x2 zeros(1,N-length(x2))];
Xf1=dft(x1,N);
Xf2=dft(x2,N);
Xf=Xf1.*Xf2;
x=idft(Xf,N)
x=real(x);
subplot(231)
stem(n,x1);
title('x1(n)')
subplot(232)
stem(n,x2);
title('x2(n)')
subplot(233)
stem(n,x);
title('x(n)=IDFT(X(k))')
subplot(234)
stem(n,y1);
title('N点圆周卷积')
subplot(235)
stem(n1,y2);
title('N-1点圆周卷积')
subplot(236)
stem(n2,y3);
title('N-2点圆周卷积')
