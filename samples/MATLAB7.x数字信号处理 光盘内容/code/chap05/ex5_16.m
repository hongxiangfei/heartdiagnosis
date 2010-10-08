
% Ƶ�ʲ�������: ϣ�����ر任��
%
M = 51; alpha = (M-1)/2; Dw = 2*pi/M;
l = 0:M-1; wl = Dw*l;
k1 = 0:floor((M-1)/2); k2 = floor((M-1)/2)+1:M-1;
Hrs = [0,-j*ones(1,(M-3)/2),-0.39j,0.39j,j*ones(1,(M-3)/2)];
angH = [-alpha*Dw*k1, alpha*Dw*(M-k2)];
H = Hrs.*exp(j*angH);
h = real(ifft(H,M));
[Hr,ww,a,P]=Hr_Type3(h);
%
% ��ͼ
subplot(1,1,1)
subplot(2,1,1); k = 1:(M+1)/2;
plot(ww/pi,-Hr,wl(k)/pi,abs(H(k)),'o');
title('ϣ�����ر任��, Ƶ�ʲ������ : M = 51')
text(.82,-.3,'Ƶ�ʣ���λ��pi��'); ylabel('�����Ӧ')
set(gca,'XTickMode','manual','XTick',[0:0.2:1])
set(gca,'YTickMode','manual','YTick',[0;0.39;1]);grid
subplot(2,1,2); stem(l,h); axis([-1,M,-1,1]);
title('������Ӧ'); xlabel('n'); ylabel('h(n)');
set(gca,'XTickMode','manual','XTick',[0;alpha;M-1])
