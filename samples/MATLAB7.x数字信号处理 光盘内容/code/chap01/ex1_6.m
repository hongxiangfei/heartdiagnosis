%generate random sequence
n=200;
xn1=rand(1,n);
xn2=randn(1,n);
subplot(2,2,1),stem(xn1);
xlabel('n');ylabel('x(n)');title('rand');
grid
subplot(2,2,2),hist(xn1,10);
xlabel('n');ylabel('x(n)');title('���ȷֲ��ĸ���ͳ��');
subplot(2,2,3),stem(xn2);
xlabel('n');ylabel('x(n)');title('randn');
grid
subplot(2,2,4),hist(xn2,10);
xlabel('n');ylabel('x(n)');title('��˹�ֲ��ĸ���ͳ��');
