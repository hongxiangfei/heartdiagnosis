clear;
x=ones(1,100);
t=1:100;
b=[0.00183,0.00734,0.01101,0.00737,0.00183];
a=[1,-3.054,3.825,-2.292,0.551];
y=filter(b,a,x);
plot(t,x,'r',t,y,'k-');
grid on;
ylabel('x(n)��y(n)');
xlabel('n');
