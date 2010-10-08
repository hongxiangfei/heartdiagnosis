
%            椭圆带通滤波器设计
%                 ELLIP函数的应用
%

% 数字低通滤波器指标:            % 椭圆型带通:
ws = [0.3*pi 0.75*pi];                  % 数字阻带边缘频率
wp = [0.4*pi 0.6*pi];                   % 数字通带边缘频率
Rp = 1;	                            % 通带波动(dB) 
As = 40;                             % 阻带衰减(dB) 
Ripple = 10 ^ (-Rp/20);                 % 通带波动
Attn = 10 ^ (-As/20);                   % 阻带衰减

% 计算椭圆滤波器参数:
[N,wn] = ellipord(wp/pi,ws/pi,Rp,As);

% 数字椭圆滤波器设计:
[b,a] = ellip(N,Rp,As,wn);

% 级联型式实现:
[b0,B,A] = dir2cas(b,a)
%%b0 = 0.0197
%%B = 1.0000    1.5066    1.0000
%%    1.0000    0.9268    1.0000
%%    1.0000   -0.9268    1.0000
%%    1.0000   -1.5066    1.0000
%%A = 1.0000    0.5963    0.9399
%%    1.0000    0.2774    0.7929
%%    1.0000   -0.2774    0.7929
%%    1.0000   -0.5963    0.9399

%绘图:
figure(1); subplot(1,1,1)
[db,mag,pha,grd,w] = freqz_m(b,a);
subplot(2,2,1);plot(w/pi,mag);grid;title('幅度响应')
xlabel(''); axis([0, 1, 0, 1])
set(gca,'XTickMode','manual','XTick',[0;0.3;0.4;0.6;0.75;1])
set(gca,'YTickMode','manual','YTick',[0,Ripple,1]);
subplot(2,2,3);plot(w/pi,db);grid;title('幅度(dB)')
xlabel('数字频率（单位：pi）'); axis([0 1 -50 0]);
set(gca,'XTickMode','manual','XTick',[0;0.3;0.4;0.6;0.75;1])
set(gca,'YTickMode','manual','YTick',[-40;0])
set(gca,'YTickLabelMode','manual','YTickLabels',['40';' 0'])
subplot(2,2,2);plot(w/pi,pha/pi);grid;title('相位响应')
xlabel('');ylabel('相位（单位：pi）') 
set(gca,'XTickMode','manual','XTick',[0;0.3;0.4;0.6;0.75;1])
subplot(2,2,4);plot(w/pi,grd);grid;title('群延迟')
xlabel('数字频率（单位：pi）'); ylabel('样本')
set(gca,'XTickMode','manual','XTick',[0;0.3;0.4;0.6;0.75;1])
