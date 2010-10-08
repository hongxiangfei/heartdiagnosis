
M = 25; alpha = (M-1)/2;
n = 0:M-1;
hd = (2/pi)*((sin((pi/2)*(n-alpha)).^2)./(n-alpha)); hd(alpha+1)=0;
w_han = (hanning(M))';
h = hd .* w_han;
[Hr,w,P,L] = Hr_Type3(h);
% 画图
subplot(1,1,1);
subplot(2,2,1); stem(n,hd); title('理想脉冲响应')
axis([-1 M -1.2 1.2]); ylabel('hd(n)');text(M+1,-1.2,'n')
subplot(2,2,2); stem(n,w_han);title('汉宁窗')
axis([-1 M 0 1.2]);  ylabel('w(n)');text(M+1,-1.2,'n')
subplot(2,2,3); stem(n,h);title('实际脉冲响应')
axis([-1 M -1.2 1.2]);xlabel('n'); ylabel('h(n)')
w = w'; Hr = Hr';
w = [-fliplr(w), w(2:501)]; Hr = [-fliplr(Hr), Hr(2:501)];
subplot(2,2,4);plot(w/pi,Hr); title('振幅响应');grid;
xlabel('频率（单位：pi）'); ylabel('Hr')
axis([-1 1 -1.1 1.1]); 
set(gca,'XTickMode','manual','XTick',[-1,0,1])
set(gca,'YTickMode','manual','YTick',[-1,0,1])