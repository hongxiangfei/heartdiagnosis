function [P,t]=shannon(s,Fs)
%对重构信号S求归一化平均香浓能量
N=floor(Fs*0.02);
count=1;
x_norm=s/max(abs(s));
len=length(s);
for i=1:N/2:len
    E(count)=0;
    for j=i:i+N-1
        if(j<=len)
            E(count)=E(count)-abs(x_norm(j))^2*log(abs(x_norm(j))^2)/N;
        end
    end
    count=count+1;
end
t=(1:length(E))*N/2/Fs;
P=(E-mean(E))./std(E);

plot(t,P);
% %%3-order
% count=1;
% for i=1:N/2:len
%     E3(count)=0;
%     for j=i:i+N-1
%         if(j<=len)
%             E3(count)=E3(count)-abs(x_norm(j))^3*log(abs(x_norm(j))^3)/N;
%         end
%     end
%     count=count+1;
% end
% P3=(E3-mean(E3))./std(E3);
% subplot(2,1,1)
% plot(t,P)
% xlabel('Time(s)');ylabel('Amplitude');
% title('2-order formulae')
% subplot(2,1,2)
% plot(t,P3)
% xlabel('Time(s)');ylabel('Amplitude');
% title('3-order formulae')
% for i=1:length(P3)
%     if P3(i)>0.1
%         PP(i)=3;
%     else PP(i)=0;
%     end
% end
% start=(find(diff(PP)==3))*N/2/Fs;
% ending=(find(diff(PP)==-3)+1)*N/2/Fs;
% S=ending-start;
% figure
% plot(t,PP,'r-')
% hold on
% axis([0 5 -5 5])
% xlabel('Time(s)');ylabel('Amplitude');
% s1=s./max(s) - 2;
% plot((1:length(s1))/Fs,s1)
% for i=1:length(start)
%     plot(start(i),-3:0.01:-1,'r')
%     plot(ending(i),-3:0.01:-1,'r')
% end
% hold off