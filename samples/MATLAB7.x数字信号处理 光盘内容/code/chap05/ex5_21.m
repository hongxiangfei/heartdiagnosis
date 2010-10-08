
% 用PM算法进行的差分器设计
%
f = [0 0.2 0.4 0.6 0.8 1];         % 单位： w/pi 
%m = [1 1 2 2 3 3];                 % 单位：sam/cycle （旧版本）
m = [0,0.1,0.4,0.6,1.2,1.5];       % 新学生版本
h = remez(25,f,m,'differentiator');
[db,mag,pha,grd,w] = freqz_m(h,[1]);
figure(1); subplot(1,1,1)
subplot(2,1,1); stem([0:25],h); title('脉冲响应e');
ylabel('h(n)'); axis([0,25,-0.6,0.6]);text(26,-0.6,'n')
set(gca,'XTickMode','manual','XTick',[0,25])
set(gca,'YTickMode','manual','YTick',[-0.6:0.2:0.6]);
subplot(2,1,2); plot(w/(2*pi),mag); title('幅度响应')
xlabel('归一化频率f'); ylabel('|H|')
set(gca,'XTickMode','manual','XTick',f/2)
set(gca,'YTickMode','manual','YTick',m)
grid