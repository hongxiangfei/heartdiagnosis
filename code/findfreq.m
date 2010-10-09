function sum = findfreq(P,f)
%% 
len = length(P);
Pmax = max(P);
fmax = find(P==Pmax);
Pget = dbtop(-3,Pmax);

fline = f(1):0.1:f(len);
% plot(fline,Pget,'r')
%% 确定f1和f2的位置
%确定f1
i = 1;
while(i < fmax)
    Nmin = fmax - i;
    if(P(Nmin) < Pget)
        P1 = P(Nmin);
        f1 = f(Nmin);
        break;
    else
        i = i + 1;
    end
end
%确定f2
i = 1;
while(i < len - fmax)
    Nmax = fmax + i;
    if(P(Nmax) < Pget)
        P2 = P(Nmax);
        f2 = f(Nmax);
        break;
    else
        i = i + 1;
    end
end
%% 画图
% plot(f1,P1,'ro',f2,P2,'ro')
% plot(f1,0:P1/100:P1,'r',f2,0:P2/100:P2,'r')
% 
% s = sprintf('%2.1f',f1);
% text(f1-5,0,s)
% s = sprintf('%2.1f',f2);
% text(f2,0,s)
% hold off
%% 
sum = P(Nmin:Nmax)'*(wf(Nmin:Nmax))';



