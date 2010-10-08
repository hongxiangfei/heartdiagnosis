
%            脉冲不变法变换
%                  简单实例
%
subplot(1,1,1); clg
c = [1,1]; d = [1,5,6]; T = 0.1; Fs = 1/T;
[b,a] = imp_invr(c,d,T)
%%b =  1.0000   -0.8966
%%a =  1.0000   -1.5595    0.6065
% 模拟滤波器的脉冲响应
t = [0:0.01:3]; subplot(2,1,1); impz(c,d,t); 
axis([0,3,-0.1,1]);hold on
% I数字滤波器的脉冲响应
n = [0:1:3/T]; hn = filter(b,a,impseq(0,0,3/T));
stem(n*T,hn); text(3.05,-.1,'时间(秒)'); title ('脉冲响应');
xlabel('');ylabel('幅度');hold off;
% 数字滤波器的幅度响应
[db,magd,pha,grd,wd] = freqz_m(b,a);
% 模拟滤波器的幅度响应
[db,mags,pha,ws] = freqs_m(c,d,2*pi*Fs);
subplot(2,1,2); plot(ws/(2*pi),mags*Fs,wd/(2*pi)*Fs,magd)
xlabel('频率(Hz)'); title('幅度响应');
ylabel('幅度'); 
text(1.4,.5,'模拟滤波器'); text(1.5,1.5,'数字滤波器')
