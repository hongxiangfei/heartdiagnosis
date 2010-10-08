
% 用PM算法进行的高通滤波器设计 
%
ws = 0.6*pi; wp = 0.75*pi; Rp = 0.5; As = 50;
delta1 = (10^(Rp/20)-1)/(10^(Rp/20)+1);
delta2 = (1+delta1)*(10^(-As/20));
deltaH = max(delta1,delta2); deltaL = min(delta1,delta2);
weights = [1 delta2/delta1];
deltaf = (wp-ws)/(2*pi);
M = ceil((-20*log10(sqrt(delta1*delta2))-13)/(14.6*deltaf)+1);
% M必须为奇数
M = 2*floor(M/2)+1
f = [0 ws/pi wp/pi 1]
m = [0 0 1 1];
h = remez(M-1,f,m,weights);
[db,mag,pha,grd,w] = freqz_m(h,[1]);
delta_w = 2*pi/1000; wsi=ws/delta_w; wpi = wp/delta_w;
Asd = -max(db(1:1:wsi))
M = M+2;
h = remez(M-1,f,m,weights);
[db,mag,pha,grd,w] = freqz_m(h,[1]);
Asd = -max(db(1:1:wsi))
M
[Hr,omega,P,L] = ampl_res(h);
%
% 画图
figure(1); subplot(1,1,1)
subplot(2,2,1); stem([0:1:M-1],h); title('实际脉冲响应')
axis([0 M-1 -0.4 0.4]); ylabel('h(n)');text(M,-0.4,'n')
set(gca,'XTickMode','manual','XTick',[0,M-1])
set(gca,'YTickMode','manual','YTick',[-0.4:0.2:0.4])
subplot(2,2,2);plot(w/pi,db);title('幅度响应（单位：dB）');
axis([0,1,-80,10]); xlabel(''); ylabel('分贝数')
set(gca,'XTickMode','manual','XTick',f)
set(gca,'YTickMode','manual','YTick',[-50,0]);grid
set(gca,'YTickLabelMode','manual','YTickLabels',['50';' 0']);
subplot(2,2,3);plot(omega/pi,Hr);title('振幅响应');
axis([0 1 -0.1 1.1]); xlabel('频率（单位：pi）'); ylabel('Hr(w)')
set(gca,'XTickMode','manual','XTick',f)
set(gca,'YTickMode','manual','YTick',[0,1]);grid
subplot(2,2,4);
sbw = omega(1:1:wsi+1)/pi; sbe = Hr(1:1:wsi+1);
pbw = omega(wpi+1:501)/pi; pbe = Hr(wpi+1:501)-1;
plot(sbw,sbe,pbw,pbe);
axis([0,1,-deltaH,deltaH]);title('误差响应');
xlabel('频率（单位：pi）'); ylabel('Hr(w)')
set(gca,'XTickMode','manual','XTick',f)
set(gca,'YTickMode','manual','YTick',[-deltaH,-deltaL,0,deltaL,deltaH]);
set(gca,'XGrid','on')