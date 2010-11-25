function PCGa = newextractsplit_s4(yyy,elps,Fs)

% % x = textread('PD1M27.003B');
% % Fs=6000;
% % %x = xiaozao(x,Fs);
% % y = denoise(x');
% % elps = envelope(y);
N=length(elps);
t=(1:N)/Fs;
%% 差分
n = N-2;
k = Fs/8;

    der(1)=0;
    der(2) =0;
    der(3) = 100* (elps(2)-elps(1));
    der(4) = (100/4) * (2*elps(3) - 2*elps(1));
    for i=5: n+2
        der(i) = k * (elps(i)+2*elps(i-1)-2*elps(i-3)-elps(i-4));
    end
    for i=1:n
        der(i) = der(i+2);
    end
    for i=n+1:length(der(:))
        der(i) = 0;
    end
%     subplot(211);
%     grid on
% %  subplot(212);
% % der=diff(elps);
% plot(t,der);
%   grid on
%%
subplot(211)
t1=(1:length(yyy))/(length(yyy)/10);
plot(t1,yyy)
 subplot(212);
plot(t,elps);
  grid on
xlabel('Time(s)');ylabel('Amplitude');
hold on
maximum=find(diff(sign(diff(elps)))==-2)+1;%极大值点的index
maxth=max(elps(maximum))*0.4;

k=1;
peak=[];
while length(peak) <= 15
    if ~isempty(peak)
        peak = [];
        interval = [];
        maxth = maxth * 4 / 5;
        k = 1;
    end
    for i=1:length(maximum)
        if(elps(maximum(i))>maxth)
            peak(k)=maximum(i);
            k=k+1;
        end
    end
    
    interval=diff(peak);
    low_level = 0.2 * Fs;
    i=1;
    while(i<=length(interval))
        if interval(i)<low_level
    %         if interval(i)*N/2/Fs<0.05  %心音分裂
              ratio = elps(peak(i)) / elps(peak(i+1));
              if ratio >0.9 && ratio < 10/9  % 差不多大，选择第一个
                  if i < length(interval)
                    interval(i+1) = interval(i) + interval(i+1);
                  end
                  interval(i) = [];
                  peak(i+1) = [];
              elseif elps(peak(i)) >= elps(peak(i+1))
                  if i < length(interval)
                    interval(i+1) = interval(i) + interval(i+1);
                  end
                  interval(i) = [];
                  peak(i+1) = [];
              else
                  if i > 1
                    interval(i-1) = interval(i-1) + interval(i);
                  end
                  interval(i) = [];
                  peak(i) = [];
              end
              continue;
        end
        i=i+1;
    end
end


maxline=ones(1,length(elps))*maxth;
plot(t,maxline,'r')
%恢复漏检的峰值
mininterval = min(interval);
minheight = min(elps(peak));
i=1;
while i<=length(interval)
    if interval(i) > 2.2 * mininterval
        middle = floor(((peak(i) + peak(i+1))/2));
        window = floor((middle + peak(i))/2) : floor((middle + peak(i+1))/2);
        extra_peaks = window(find(diff(sign(diff(elps(window))))==-2)+1);
        index = find(elps(extra_peaks) == max(elps((extra_peaks))));
        extra_peak = extra_peaks(index);
        rate1 = 1;
        rate2 = 1;
        if i == 2
            rate1 = (peak(i+1)-extra_peak)/(peak(i)-peak(i-1));
        elseif i > 2
            rate1 = (peak(i+1)-extra_peak)/(peak(i)-peak(i-1));
            rate2 = (extra_peak-peak(i))/(peak(i-1)-peak(i-2));
        end
        if elps(extra_peak) * 2 > minheight && rate1 > 0.7 && rate1 < 10/7 && rate2 > 0.7 && rate2 < 10/7 && min(extra_peak-peak(i),peak(i+1)-extra_peak) > low_level 
            for k = length(peak) : -1 : i+1
                peak(k+1) = peak(k);
            end
            peak(k) = extra_peak;
            interval = diff(peak);
            continue;
        end
    end
    i = i + 1;
end
            
%标识S1，S2的起点和终点
flag=Fs*0.1;
index = find(interval==max(interval));
[cc1,cc2]=size(index);

if cc2>1
    index=index(1,1);
end
k=0;
for i=1:length(peak)
    plot(peak(i)/Fs,elps(peak(i)),'rs')
    if peak(i) - flag > 0
        pre = elps(peak(i) - flag : peak(i));
    else
        pre = elps(1:peak(i));
    end
    if peak(i) + flag <= length(elps)
        next = elps(peak(i) : peak(i) + flag);
    else
        next = elps(peak(i) : length(elps));
    end
    start(i)=find(pre==min(pre))+peak(i)-length(pre);
    ending(i)=find(next==min(next))+peak(i)-1;
    %%确定开始结束点是波谷
    if i~=1&& i~=length(peak)
    uu=start(i)+5;
    yy=ending(i)-5;
    for uuu=1:3000
        if der(uu-uuu)>0 && der(uu-uuu-1)<0
        break;
        end
    end
    start(i)=uu-uuu;
     for yyy=1:3000
        if der(yy+yyy)<0 && der(yy+yyy+1)>0
        break;
        end
     end
     ending(i)=yy+yyy;
    end   
  %
   plot(start(i)/Fs,elps(start(i)),'r*');
   plot(ending(i)/Fs,elps(ending(i)),'ro');
    if rem(i-index,2)==0&&peak(i)<n-50
       text(peak(i)/Fs,elps(peak(i))*1.03,'S2')
         c=peak(i);
         c=c+50;
         t1=0;
         mb=-1;
         while c<ending(i)-50
              c=c+1;
                if der(c)>0&&der(c+1)<0
                    t1=t1+1;
                    if t1==1;
                    mb=c;
                    else
                        if elps(mb)<elps(c)
                            mb=c;
                        end
                        
                     end
                end
         end
         c=mb;
         if c==peak(i)||c==-1
             c=0;
         end
        
          p2(i)=c;
          if c>0
          plot(c/Fs,elps(p2(i)),'gh');
          end
          
           %find s3 在说结束的0.1-0.3s中找s3峰值
          fc=(0.3*Fs)-(0.1*Fs); 
          lp=0;
          for m=0:fc-1
              H=peak(i)+600+m;
             
              if H<=N-1
                a=der(H);
                b=der(H+1);
                 ccc=a-b;
                 
              if der(H)>0&&der(H+1)<0
                  if lp==0
                    lp=H;  
                  end 
                  if elps(H)>elps(lp)
                      lp=H;
                  end
                   
              end
              end
          end
          if lp~=0
              H=lp;
         if H<N-1 
             plot(H/Fs,elps(H),'rs');
             text(H/Fs,elps(H)*1.03,'S3')
             s3H(i)=elps(H);
          %find s3start and  ending
                 for mm=1:H-ending(i)+1
                    s=H-mm;
                  if der(s)>0 &&der(s-1)<0
                     break
                  end
                 end
            if mm==H-ending(i)
                s3start(i)=ending(i);%没找到s3起始点 将s2结束作为s3起始点
            else
                s3start(i)=s;
            end
            % ending s3
            if i==length(peak)
              for mmm=1:N-H-1
                e=H+mmm;
                if der(e)<0 &&der(e+1)>0
                 break
                end
              end
               if mmm==N-H
                s3ending(i)=N;%没找到s3终止点 将最后一点作为s3终止点
               else
                s3ending(i)=e;
               end
            else
                
                 for mmm=1:0.1*Fs
                    e=H+mmm;
                  if der(e)<0 &&der(e+1)>0
                    break
                  end
                 end
                 
                    s3ending(i)=e;%没找到s3终止点 将下一个s1起始点作为s3终止点
      
               
            end
            plot(s3start(i)/Fs,elps(s3start(i)),'c*');
             plot(s3ending(i)/Fs,elps(s3ending(i)),'co');
            %%
          else
             s3H(i) =0;  
           s3ending(i)=0;
           s3start(i)=0; 
          end
          else
           s3H(i) =0;  
           s3ending(i)=0;
           s3start(i)=0;
          end
          
        if i~=1 && i~=length(peak)
            PCGa(k).s2start = start(i);
            PCGa(k).s2end = ending(i);
            PCGa(k).s2peak = peak(i);
             PCGa(k).s2H = elps(peak(i));
              PCGa(k).s3H=s3H(i);
              PCGa(k).s3start=s3start(i);
               PCGa(k).s3end=s3ending(i);
              if c==ending(i)||c==0;
                PCGa(k).p2H=0;
                 PCGa(k).p2H_L=0;
              else
               PCGa(k).p2H = elps(p2(i));
             PCGa(k).p2H_L=c;  
              end
        end
   else rem(i-index,2)~=0&&peak(i)< n-50
         text(peak(i)/Fs,elps(peak(i))*1.03,'S1')

         b=peak(i);
         b1=b-5;
      t=0;
      ma=0;
      while b1>start(i)+50
        b1=b1-1;
        if der(b1)<0&&der(b1-1)>0
            t=t+1;
            if t==1
               ma=b1;
            else
                if elps(ma)<elps(b1)
                    ma=b1;
                end
            end
          
        end
      end
      b1=ma;
      if b1==b||b1<0;
          b1=0;
      end
      %向右找
       b2=b+5;
      t=0;
      ma=0;
      while b2<ending(i)-50
        b2=b2+1;
        if der(b2)>0&&der(b2+1)<0
            t=t+1;
            if t==1
               ma=b2;
            else
                if elps(ma)<elps(b2)
                    ma=b2;
                end
            end
          
        end
      end
      b2=ma;
      %
      if b2==b||b2==N;
          b2=0;
      end
      %判断左大 把b1付给m1（i），右da 把b2付给t1
     if b1~=0 && b2~=0
      if elps(b1)>elps(b2)
          m1(i)=b1;
          t1(i)=peak(i);
          plot(b1/Fs,elps(m1(i)),'yh');
          
      else
          m1(i)=peak(i);
          t1(i)=b2;
           plot(b2/Fs,elps(t1(i)),'yh');
          
      end
     else
         if b1~=0 && b2==0
             m1(i)=b1;
             t1(i)=peak(i);
             plot(b1/Fs,elps(m1(i)),'yh');
         end
         if b1==0&&b2~=0
             m1(i)=peak(i);
          t1(i)=b2;
           plot(b2/Fs,elps(t1(i)),'yh');
         end 
         if b1==0&&b2==0
              m1(i)=peak(i);
               t1(i)=0;
         end
     end
     %

       
        if k~=0
            PCGa(k).ns1start = start(i);
        end
        %%找出s4的峰值
            aa=round(start(i));
            bb=round(start(i)-0.1*Fs);
            cccc=start(i);
            if aa>2
                for n1=1:aa-bb-1
                    cc=aa-n1;
                   
                    if cc>2
                      if der(cc)<0&&der(cc-1)>0
                            if (elps(cccc)<elps(cc))
                              cccc=cc;
                            end
                       end
                    else 
                        s4H(i)=0;
                        break; 
                    end
                end
                cc=cccc;
               if cc>2&&cc~=start(i)
                   s4H(i)=elps(cc);
                   %找起始点 
                   if bb>0
                       oo1=cc-bb;
                   else
                       oo1=cc-1;
                   end
                   ss=bb+1;
                   for nn=1:oo1-1
                       ss=cc-nn;
                           if der(ss)>0&& der(ss-1)<0
                               break;
                           end
                   end

                           if ss==bb+1
                               s4start(i)=bb;
                           else
                               s4start(i)=ss;
                           end
                    %终止点
                   for nnn=1:aa-cc-1
                           sss=cc+nnn;
                           if der(sss)<0&& der(sss+1)>0
                               break;
                           end
                   end 
                   if sss==aa-1
                               s4ending(i)=aa;
                    else
                               s4ending(i)=sss;
                   end
               else
                   s4H(i)=0;
                s4start(i)=0;
                s4ending(i)=0; 
               end
            else
                s4H(i)=0;
                s4start(i)=0;
                s4ending(i)=0;
            end
            if s4H(i)~=0
         plot(cc/Fs,s4H(i),'rs');
          text(cc/Fs,s4H(i)*1.03,'S4')
           plot(s4start(i)/Fs,elps(s4start(i)),'c*');
             plot(s4ending(i)/Fs,elps(s4ending(i)),'co');
            end
        if i~=length(peak) && i~=length(peak)-1
            k = k + 1;
            PCGa(k).s1start = start(i);
            PCGa(k).s1end = ending(i);
            PCGa(k).s1peak = peak(i);
            PCGa(k).s1H = elps(peak(i));
            PCGa(k).s4H = s4H(i);
            PCGa(k).s4start = s4start(i);
            PCGa(k).s4end = s4ending(i);
             
            if m1(i)~=0
            PCGa(k).m1H=elps(m1(i));
            else
                 PCGa(k).m1H=0;
            end
             PCGa(k).m1H_L=m1(i);
            if b1==start(i);
                PCGa(k).m1H=0;
                PCGa(k).m1H_L=0;
            end
            
            %
            if t1(i)~=0
            PCGa(k).t1H=elps(t1(i));
            PCGa(k).t1H_L=t1(i);
            else
                 PCGa(k).t1H=0;
                 PCGa(k).t1H_L=0;
            end
             
            if t1(i)==start(i);
                PCGa(k).t1H=0;
                 PCGa(k).t1H_L=0;
            end
            %
         end
   end
 end

%


        