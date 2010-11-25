%根据计算出来的PCG结构体，可以计算很多特征值，
%例如心率，s1时限，s2时限，s1峰值，s2峰值等等 p2H_l 是p2对应的时间
%注意：所有特征都是几个心动周期的平均值
function S92=featuress_Shannon(PCG,elp,Fs)
n=length(PCG);
fs=floor(length(elp)/10);
sum_hrate = 0;

s1=zeros(1,4);
s2=zeros(1,4);
D=zeros(1,12);
S=zeros(1,24);
for i=1:n
    sum_hrate = sum_hrate + PCG(i).ns1start-PCG(i).s1start;
    sum_s(i)=PCG(i).ns1start-PCG(i).s1start;
    sum_s1H(i)=PCG(i).s1H;
     sum_s2H(i)=PCG(i).s2H;
    %%S1 8bufen
    ns1=PCG(i).s1end - PCG(i).s1start+1;
    ans1=floor(ns1/4);
    for j=1:4 
        s1a=PCG(i).s1start+(j-1)*ans1;
        s1b=PCG(i).s1start+(j)*ans1-1;
        if ans1<=1
            s1(j)=s1(j)+0;
        else
        s1(j)=s1(j)+var(elp(s1a:s1b));
        end
    end
    
    %%S2 8bufen
    ns2=PCG(i).s2end - PCG(i).s2start+1;
    ans2=floor(ns2/4);
    for j=1:4 
        s2a=PCG(i).s2start+(j-1)*ans2;
        s2b=PCG(i).s2start+(j)*ans2-1;
        if ans2<=1
            s2(j)=s2(j)+0;
        else
        s2(j)=s2(j)+var(elp(s2a:s2b));
        end
    end
    
      %%D 24bufen
    nD=PCG(i).s2start-PCG(i).s1start+1;
    anD=floor(nD/12);
    for j=1:12 
        Da=PCG(i).s1start+(j-1)*anD;
        Db=PCG(i).s1start+(j)*anD-1;
          if anD<=1
                D(j)=D(j)+0;
          else
            D(j)=D(j)+var(elp(Da:Db));
          end
    end
    
       %%S 48bufen
       if i~=n
          nS=PCG(i+1).s1start-PCG(i).s2start+1;
          anS=floor(nS/24);
          for j=1:24 
            Sa=PCG(i).s2start+(j-1)*anS;
            Sb=PCG(i).s2start+(j)*anS-1;
            if anS<=1
                S(j)=S(j)+0;
            else
               S(j)=S(j)+var(elp(Sa:Sb));
            end
          end   
       end
end


hrate = 60/(sum_hrate/n/fs);

    sum_s=var(sum_s/fs);
    sum_s1H=var(sum_s1H);
    sum_s2H=var(sum_s2H);

s1=s1/n;
s2=s2/n;
D=D/n;
S=S/(n-1);
%% 写入 S92
S92(1:4)=s1;
S92(5:16)=D;
S92(17:20)=s2;
S92(21:44)=S;
S92(45)=hrate;
S92(46)=sum_s;
S92(47)=sum_s1H;                                                                                                                                                                     
S92(48)=sum_s2H;