
% ��PM�㷨���еĽ����˲������
%
w1 = 0; w2 = 0.3*pi; delta1 = 0.01;
w3 = 0.4*pi; w4 = 0.7*pi; delta2 = 0.005;
w5 = 0.8*pi; w6 = pi; delta3 = 0.001;
deltaH = max([delta1,delta2,delta3]); deltaL = min([delta1,delta2,delta3]);
weights = [delta3/delta1 delta3/delta2 1]
delta_f = min((w3-w2)/(2*pi), (w5-w3)/(2*pi))
M = ceil((-20*log10(sqrt(delta1*delta2))-13)/(14.6*delta_f)+1)
f = [0 w2/pi w3/pi w4/pi w5/pi 1]
m = [1 1 0.5 0.5 0 0];
h = remez(M-1,f,m,weights);
[db,mag,pha,grd,w] = freqz_m(h,[1]);
delta_w = 2*pi/1000;
w1i=floor(w1/delta_w)+1; w2i = floor(w2/delta_w)+1;
w3i=floor(w3/delta_w)+1; w4i = floor(w4/delta_w)+1;
w5i=floor(w5/delta_w)+1; w6i = floor(w6/delta_w)+1;
Asd = -max(db(w5i:w6i))
% M��49ʱ�ҵ�����ֵ
M = 49;
h = remez(M-1,f,m,weights);
[db,mag,pha,grd,w] = freqz_m(h,[1]);
Asd = -max(db(w5i:w6i))
[Hr,omega,P,L] = ampl_res(h);
%
% ��ͼ
figure(1); subplot(1,1,1)
subplot(2,2,1); stem([0:1:M-1],h); title('ʵ��������Ӧ')
axis([0,M-1,-0.1,0.6]); ylabel('h(n)');text(M,-0.1,'n')
set(gca,'XTickMode','manual','XTick',[0,M-1])
set(gca,'YTickMode','manual','YTick',[-0.1:0.1:0.6])
subplot(2,2,2);plot(w/pi,db);title('������Ӧ����λ��dB��');
axis([0,1,-80,10]); xlabel(''); ylabel('�ֱ���')
set(gca,'XTickMode','manual','XTick',f)
set(gca,'YTickMode','manual','YTick',[-60,0]);
set(gca,'YTickLabelMode','manual','YTickLabels',['60';' 0']);grid
subplot(2,2,3);plot(omega/pi,Hr);title('�����Ӧ');
axis([0 1 -0.1 1.1]); xlabel('Ƶ�ʣ���λ��pi��'); ylabel('Hr(w)')
set(gca,'XTickMode','manual','XTick',f)
set(gca,'YTickMode','manual','YTick',[0,0.5,1]);grid
delta_w = 2*pi/1000; sp_edge = w5/delta_w+1;
subplot(2,2,4); 
b1w = omega(w1i:w2i)/pi; b1e = (Hr(w1i:w2i)-m(1))*weights(1); 
b2w = omega(w3i:w4i)/pi; b2e = (Hr(w3i:w4i)-m(3))*weights(2); 
b3w = omega(w5i:w6i)/pi; b3e = (Hr(w5i:w6i)-m(5))*weights(3); 
plot(b1w,b1e,b2w,b2e,b3w,b3e);
title('��Ȩ���');
axis([0,1,-delta3,delta3]);
xlabel('Ƶ�ʣ���λ��pi��'); ylabel('Hr(w)')
set(gca,'XTickMode','manual','XTick',f)
set(gca,'YTickMode','manual','YTick',[-delta3,0,delta3]);
grid
