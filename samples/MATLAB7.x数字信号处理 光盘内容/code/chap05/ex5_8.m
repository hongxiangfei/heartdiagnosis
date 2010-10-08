%  带通滤波器设计 - 布莱克曼窗
%
ws1 = 0.2*pi; wp1 = 0.35*pi;
wp2 = 0.65*pi; ws2 = 0.8*pi;
As = 60;
tr_width = min((wp1-ws1),(ws2-wp2))
M = ceil(11*pi/tr_width) + 1 %;M=68
n=[0:1:M-1];
wc1 = (ws1+wp1)/2; wc2 = (wp2+ws2)/2;
hd = ideal_lp(wc2,M) - ideal_lp(wc1,M);
w_bla = (blackman(M))';
h = hd .* w_bla;
[db,mag,pha,grd,w] = freqz_m(h,[1]);
delta_w = 2*pi/1000;
Rp = -min(db(wp1/delta_w+1:1:wp2/delta_w)) % 实际的通带波动
As = -round(max(db(ws2/delta_w+1:1:501))) % 最小阻带衰减
% 画图
subplot(1,1,1);
subplot(2,2,1); stem(n,hd); title('理想脉冲响应')
axis([0 M-1 -0.4 0.5]);  ylabel('hd(n)');text(M+1,-0.4,'n')
subplot(2,2,2); stem(n,w_bla);title('布莱克曼窗')
axis([0 M-1 0 1.1]); ylabel('w(n)');text(M+1,0,'n')
subplot(2,2,3); stem(n,h);title('实际脉冲响应')
axis([0 M-1 -0.4 0.5]); xlabel('n'); ylabel('h(n)')
subplot(2,2,4);plot(w/pi,db);%set(gca,'FontName','cmr12');
title('幅度响应（单位：dB）');grid;
xlabel('频率（单位： pi）'); ylabel('分贝数')
axis([0 1 -150 10]); 
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,0.65,0.8,1])
set(gca,'YTickMode','manual','YTick',[-60,0])
set(gca,'YTickLabelMode','manual','YTickLabels',['60';' 0'])