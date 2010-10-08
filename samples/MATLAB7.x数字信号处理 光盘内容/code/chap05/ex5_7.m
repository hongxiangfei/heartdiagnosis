% 低通滤波器设计 - 哈明窗
%
wp = 0.2*pi; ws = 0.3*pi;
tr_width = ws - wp
M = ceil(6.6*pi/tr_width) + 1
n=[0:1:M-1];
wc = (ws+wp)/2
hd = ideal_lp(wc,M);
w_ham = (hamming(M))';
h = hd .* w_ham;
[db,mag,pha,grd,w] = freqz_m(h,[1]);
delta_w = 2*pi/1000;
Rp = -(min(db(1:1:wp/delta_w+1)))        % 通带波动
As = -round(max(db(ws/delta_w+1:1:501))) % 最小阻带衰减
% 画图
subplot(1,1,1)
subplot(2,2,1); stem(n,hd); title('理想脉冲响应')
axis([0 M-1 -0.1 0.3]); ylabel('hd(n)');text(M+1,-0.1,'n')
subplot(2,2,2); stem(n,w_ham);title('哈明窗')
axis([0 M-1 0 1.1]); ylabel('w(n)');text(M+1,0,'n')
subplot(2,2,3); stem(n,h);title('实际脉冲响应')
axis([0 M-1 -0.1 0.3]); xlabel('n'); ylabel('h(n)')
subplot(2,2,4); plot(w/pi,db);title('幅度响应（单位： dB）');grid
axis([0 1 -100 10]); xlabel('频率（单位：pi）'); ylabel('分贝')
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1])
set(gca,'YTickMode','manual','YTick',[-50,0])
set(gca,'YTickLabelMode','manual','YTickLabels',['50';' 0'])