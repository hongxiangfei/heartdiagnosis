%  ��ͨ�˲������ - ����������
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
Rp = -min(db(wp1/delta_w+1:1:wp2/delta_w)) % ʵ�ʵ�ͨ������
As = -round(max(db(ws2/delta_w+1:1:501))) % ��С���˥��
% ��ͼ
subplot(1,1,1);
subplot(2,2,1); stem(n,hd); title('����������Ӧ')
axis([0 M-1 -0.4 0.5]);  ylabel('hd(n)');text(M+1,-0.4,'n')
subplot(2,2,2); stem(n,w_bla);title('����������')
axis([0 M-1 0 1.1]); ylabel('w(n)');text(M+1,0,'n')
subplot(2,2,3); stem(n,h);title('ʵ��������Ӧ')
axis([0 M-1 -0.4 0.5]); xlabel('n'); ylabel('h(n)')
subplot(2,2,4);plot(w/pi,db);%set(gca,'FontName','cmr12');
title('������Ӧ����λ��dB��');grid;
xlabel('Ƶ�ʣ���λ�� pi��'); ylabel('�ֱ���')
axis([0 1 -150 10]); 
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,0.65,0.8,1])
set(gca,'YTickMode','manual','YTick',[-60,0])
set(gca,'YTickLabelMode','manual','YTickLabels',['60';' 0'])