
%            切比雪夫-1型低通滤波器设计
%
Wp = 0.2*pi; Ws = 0.3*pi; Rp = 1; As = 16;
Ripple = 10 ^ (-Rp/20); Attn = 10 ^ (-As/20);

% 模拟滤波器设计:
[b,a] = afd_chb1(Wp,Ws,Rp,As);
%*** 切比雪夫-1型 滤波器阶次 =  4 

% 计算二阶环节部分:
[C,B,A] = sdir2cas(b,a)
%%C = 0.0383
%%B = 0     0     1
%%A = 1.0000    0.4233    0.1103
%%    1.0000    0.1753    0.3895

% 计算频率响应:
[db,mag,pha,w] = freqs_m(b,a,0.5*pi);

% 计算脉冲响应:
[ha,x,t] = impulse(a,b);

% Plots
subplot(2,2,1); plot(w/pi,mag);title('幅度响应')
xlabel('模拟频率（单位：pi）'); ylabel('|H|'); axis([0,0.5,0,1.1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,0.5]);
set(gca,'YTickmode','manual','YTick',[0,Attn,Ripple,1]); grid
subplot(2,2,2); plot(w/pi,db);title('幅度(dB)')
xlabel('模拟频率（单位：pi）'); ylabel('分贝'); axis([0,0.5,-30,5])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,0.5]);
set(gca,'YTickmode','manual','YTick',[-30,-As,-Rp,0]); grid
set(gca,'YTickLabelMode','manual','YTickLabels',['30';'16';' 1';' 0'])
subplot(2,2,3); plot(w/pi,pha/pi); title('相位响应')
xlabel('模拟频率（单位：pi）'); ylabel('弧度'); axis([0,0.5,-1,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,0.5]);
set(gca,'YTickmode','manual','YTick',[-1,-0.5,0,0.5,1]); grid
subplot(2,2,4); plot(t,ha,[0,max(t)],[0,0]); title('脉冲响应')
xlabel('时间(秒)'); ylabel('ha(t)'); axis([0,max(t),min(ha),max(ha)])

