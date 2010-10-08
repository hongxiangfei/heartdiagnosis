
% ��PM�㷨���еĲ�������
%
f = [0 0.2 0.4 0.6 0.8 1];         % ��λ�� w/pi 
%m = [1 1 2 2 3 3];                 % ��λ��sam/cycle ���ɰ汾��
m = [0,0.1,0.4,0.6,1.2,1.5];       % ��ѧ���汾
h = remez(25,f,m,'differentiator');
[db,mag,pha,grd,w] = freqz_m(h,[1]);
figure(1); subplot(1,1,1)
subplot(2,1,1); stem([0:25],h); title('������Ӧe');
ylabel('h(n)'); axis([0,25,-0.6,0.6]);text(26,-0.6,'n')
set(gca,'XTickMode','manual','XTick',[0,25])
set(gca,'YTickMode','manual','YTick',[-0.6:0.2:0.6]);
subplot(2,1,2); plot(w/(2*pi),mag); title('������Ӧ')
xlabel('��һ��Ƶ��f'); ylabel('|H|')
set(gca,'XTickMode','manual','XTick',f/2)
set(gca,'YTickMode','manual','YTick',m)
grid