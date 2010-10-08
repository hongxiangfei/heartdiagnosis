
%            切比雪夫-2带阻滤波器设计
%                 CHEBY2函数的应用
%
% 数字低通滤波器指标:            % 切比雪夫-2型带阻:
ws = [0.4*pi 0.7*pi];                   % 数字阻带边缘频率
wp = [0.25*pi 0.8*pi];                  % 数字通带边缘频率
Rp = 1;	                            % 通带波动(dB) 
As = 40;                             % 阻带衰减(dB) 
Ripple = 10 ^ (-Rp/20);                 % 通带波动
Attn = 10 ^ (-As/20);                   % 阻带衰减

% 计算切比雪夫-2型滤波器参数
 [N,wn] = cheb2ord(wp/pi,ws/pi,Rp,As);

% 数字切比雪夫-2型带阻滤波器设计:
[b,a] = cheby2(N,As,ws/pi,'stop');

% 级联型式实现:
[b0,B,A] = dir2cas(b,a)
%%b0 = 0.1558
%%B = 1.0000    1.1456    1.0000
%%    1.0000    0.8879    1.0000
%%    1.0000    0.3511    1.0000
%%    1.0000   -0.2434    1.0000
%%    1.0000   -0.5768    1.0000
%%A = 1.0000    1.3041    0.8031
%%    1.0000    0.8901    0.4614
%%    1.0000    0.2132    0.2145
%%    1.0000   -0.4713    0.3916
%%    1.0000   -0.8936    0.7602

% 绘图:
[db,mag,pha,grd,w] = freqz_m(b,a);
subplot(2,2,1);plot(w/pi,mag);grid;title('频率响应')
xlabel(''); axis([0 1 0 1])
set(gca,'XTickMode','manual','XTick',[0;0.25;0.4;0.7;0.8;1])
set(gca,'YTickMode','manual','YTick',[0;Ripple;1])
subplot(2,2,3);plot(w/pi,db);grid;title('幅度(dB)')
xlabel('数字频率（单位：pi）'); axis([0 1 -50 0]);
set(gca,'XTickMode','manual','XTick',[0;0.25;0.4;0.7;0.8;1])
set(gca,'YTickMode','manual','YTick',[-40;0])
subplot(2,2,2);plot(w/pi,pha/pi);grid;title('相位响应')
xlabel('');ylabel('相位（单位：pi）') 
set(gca,'XTickMode','manual','XTick',[0;0.25;0.4;0.7;0.8;1])
subplot(2,2,4);plot(w/pi,grd);grid;title('群延迟')
xlabel('数字频率（单位：pi）'); 
set(gca,'XTickMode','manual','XTick',[0;0.25;0.4;0.7;0.8;1])
subplot;
