function [f1,f2] = findfreq(P,f)
 
len = length(P);
Pmax = max(P);
fmax = find(P==Pmax);
Pget = dbtop(-3,Pmax);

fline = f(1):0.1:f(len);
plot(fline,Pget,'r')

i = 1;
while(i < fmax)
    if(P(fmax - i) < Pget)
        P1 = P(fmax - i);
        f1 = f(fmax - i);
        break;
    else
        i = i + 1;
    end
end

i = 1;
while(i < len - fmax)
    if(P(fmax + i) < Pget)
        P2 = P(fmax + i);
        f2 = f(fmax + i);
        break;
    else
        i = i + 1;
    end
end

plot(f1,P1,'ro',f2,P2,'ro')
plot(f1,0:P1/100:P1,'r',f2,0:P2/100:P2,'r')

s = sprintf('%2.1f',f1);
text(f1-5,0,s)
s = sprintf('%2.1f',f2);
text(f2,0,s)
hold off

