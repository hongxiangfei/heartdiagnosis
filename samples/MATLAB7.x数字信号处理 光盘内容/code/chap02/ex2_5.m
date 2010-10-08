%
x = [1,1,1,1];
subplot(1,1,1);
%
% a) DTFT
w = [0:1:500]*2*pi/500;
[H] = freqz(x,1,w);
magH = abs(H); phaH = angle(H); phaH(126)=-47.5841*pi/180;
subplot(2,1,1); plot(w/pi,magH); grid
xlabel('');
ylabel('|X|’); title(' DTFT的幅度')
subplot(2,1,2); plot(w/pi,phaH/pi*180); grid
xlabel('以pi为单位的频率');
ylabel('度'); title('DTFT的相角')
%print -deps2 me0506a.eps
pause;subplot(1,1,1)
%
% b) 4-point DFT
N = 4; w1 = 2*pi/N; k = 0:N-1;
X = dft(x,N);
magX = abs(X), phaX = angle(X)*180/pi
subplot(2,1,1);plot(w*N/(2*pi),magH,'--'); 
axis([-0.1,4.1,-1,5]); hold on
stem(k,magX);
ylabel('|X(k)|'); title('DFT的幅度: N=4');text(4.3,-1,'k')
hold off
subplot(2,1,2);plot(w*N/(2*pi),phaH*180/pi,'--');
axis([-0.1,4.1,-200,200]); hold on
stem(k,phaX);
ylabel('度'); title('DFT相角: N=4');text(4.3,-200,'k')
%print -deps2 me0506b.eps
