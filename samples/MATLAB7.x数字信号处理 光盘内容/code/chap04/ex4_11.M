
%            脉冲不变法变换
%                  椭圆低通滤波器设计
%
% 数字滤波器指标:
wp = 0.2*pi;                         % 数字通带频率(弧度)
ws = 0.3*pi;                         % 数字阻带频率(弧度)
Rp = 1;                              % 通带波动(dB)
As = 15;                             % 阻带衰减(dB) 

% 模拟原型指标的频率逆映射
T = 1;                               % 置 T=1
OmegaP = wp * T;                     % 原型通带频率
OmegaS = ws * T;                     % 原型阻带频率
ep = sqrt(10^(Rp/10)-1);             % 通带波动参数
Ripple = sqrt(1/(1+ep*ep));          % 通带波动
Attn = 1/(10^(As/20));               % 阻带衰减

% 模拟椭圆原型滤波器计算:
[cs,ds] = afd_elip(OmegaP,OmegaS,Rp,As);
%%*** 椭圆滤波器阶次=  3

% 脉冲恒定变换:
 [b,a] = imp_invr(cs,ds,T);
[C,B,A] = dir2par(b,a)
%%C =  []
%%B =-0.1600    0.1299
%%    0.4560         0
%%A = 1.0000   -1.4854    0.8521
%%    1.0000   -0.6338         0

% 绘图
figure(1); subplot(1,1,1)
[db,mag,pha,grd,w] = freqz_m(b,a);
subplot(2,2,1); plot(w/pi,mag); title('幅度响应')
xlabel(''); ylabel('|H|'); axis([0,1,0,1.1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0,Attn,Ripple,1]); grid
subplot(2,2,3); plot(w/pi,db); title('幅度(dB)');
xlabel('频率（频率：pi）'); ylabel('分贝'); axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-50,-15,-1,0]); grid
set(gca,'YTickLabelMode','manual','YTickLabels',['50';'15';' 1';' 0'])
subplot(2,2,2); plot(w/pi,pha/pi); title('相位响应')
xlabel(''); ylabel('单位：pi'); axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-1,0,1]); grid
subplot(2,2,4); plot(w/pi,grd); title('群延迟')
xlabel('频率：（单位：pi）'); ylabel('样本'); axis([0,1,0,15])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0:5:15]); grid

