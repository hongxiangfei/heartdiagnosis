
% ��PM�㷨���е�ϣ�����ر任����� 
%
f = [0.05,0.95]; m = [1 1]; M = 51; N = M-1;
h = remez(N,f,m,'hilbert');
[db,mag,pha,grd,w] = freqz_m(h,[1]);
figure(1); subplot(1,1,1)
subplot(2,1,1); stem([0:N],h); title('������Ӧ');
ylabel('h(n)'); axis([0,N,-0.8,0.8]);text(N+1,-0.8,'n')
set(gca,'XTickMode','manual','XTick',[0,N])
set(gca,'YTickMode','manual','YTick',[-0.8:0.2:0.8]);
subplot(2,1,2); plot(w/pi,mag); title('������Ӧ')
xlabel('Ƶ�ʣ���λ��pi��'); ylabel('|H|')
set(gca,'XTickMode','manual','XTick',[0,f,1])
set(gca,'YTickMode','manual','YTick',[0,1]);grid