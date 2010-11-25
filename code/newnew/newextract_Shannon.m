function PCG=newextract_Shannon(yyy,envelope,Fs)

N=length(envelope);
t=(1:N)/(N/10);
subplot(211)
plot(t,envelope)
xlabel('Time(s)');ylabel('Amplitude');
hold on
maximum=find(diff(sign(diff(envelope)))==-2)+1;%极大值点的index
ma=sort(envelope(maximum));
lma=length(ma);
maxth=max(envelope(maximum));
maxth2=ma(lma-1);
maxth3=ma(lma-2);
        if maxth<=20 
            if maxth/maxth2>3 ||maxth/maxth3>3
                maxth = maxth * 0.04; 
            else
               maxth = maxth *0.08;
            end
        else
            if maxth>20 &&maxth<=30
                if maxth/maxth2>3 ||maxth/maxth3>3
                     maxth = maxth * 0.03; 
                else
                   maxth = maxth * 0.06; 
                end
            else
                 if maxth/maxth2>3 ||maxth/maxth3>3
                     maxth = maxth * 0.02; 
                 else
                 maxth = maxth * 0.02; 
                 end
            end
        end


k=1;
peak=[];
while length(peak) <13
    if ~isempty(peak)
        peak = [];
        interval = [];
        if maxth<=20
           maxth = maxth * 1/6;
        else
           maxth = maxth * 1/6; 
        end
        k = 1;
    end
    if maxth<0.2
        maxth=0.2;
    end
    for i=1:length(maximum)
        if(envelope(maximum(i))>maxth)
            peak(k)=maximum(i);
            k=k+1;
        end
    end
    interval=diff(peak);
    low_level = 0.02* 980;
    i=1;
    while(i<=length(interval))
        if interval(i)<low_level
    %         if interval(i)*N/2/Fs<0.05  %心音分裂
              ratio = envelope(peak(i)) / envelope(peak(i+1));
              if ratio <0.1 && ratio >1.1   % 差不多大，选择第一个
                  if i < length(interval)
                    interval(i+1) = interval(i) + interval(i+1);
                  end
                  interval(i) = [];
                  peak(i+1) = [];
                  elseif envelope(peak(i)) >= envelope(peak(i+1))
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

maxline=ones(1,length(envelope))*maxth;
plot(t,maxline,'r')
for i=1:length(peak)
    
        plot(peak(i)/(N/10),envelope(peak(i)),'r+')
     
end
%恢复漏检的峰值
mininterval = min(interval);
minheight = min(envelope(peak));
i=1;
while i<=length(interval)
    if interval(i) > 2.5* mininterval
        middle = floor(((peak(i) + peak(i+1))/2));
        window = floor((middle + peak(i))/2) : floor((middle + peak(i+1))/2);
        extra_peaks = window(find(diff(sign(diff(envelope(window))))==-2)+1);
        index = find(envelope(extra_peaks) == max(envelope((extra_peaks))));
        extra_peak = extra_peaks(index);
        rate1 = 1;
        rate2 = 1;
        if i == 2
            rate1 = (peak(i+1)-extra_peak)/(peak(i)-peak(i-1));
        elseif i > 2
            rate1 = (peak(i+1)-extra_peak)/(peak(i)-peak(i-1));
            rate2 = (extra_peak-peak(i))/(peak(i-1)-peak(i-2));
        end
        if envelope(extra_peak) * 2 > minheight*0.8 && rate1 > 0.5 && rate1 < 10/5 && rate2 > 0.5 && rate2 < 10/5 && min(extra_peak-peak(i),peak(i+1)-extra_peak) > low_level 
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
for i=1:length(peak)
   
      plot(peak(i)/(N/10),envelope(peak(i)),'r+')
     

end

            
%标识S1，S2的起点和终点
flag=round((N/10)*0.1);
index = find(interval==max(interval)) ; 
k=0;
for i=1:length(peak)
    plot(peak(i)/(N/10),envelope(peak(i)),'rs')
    if peak(i) - flag > 0
        pre = envelope(peak(i) - flag : peak(i));
    else
        pre = envelope(1:peak(i));
    end
    if peak(i) + flag <= length(envelope)
        next = envelope(peak(i) : peak(i) + flag);
    else
        next = envelope(peak(i) : length(envelope));
    end
    start(i)=find(pre==min(pre))+peak(i)-length(pre);
    ending(i)=find(next==min(next))+peak(i)-1;
   plot(start(i)/(N/10),envelope(start(i)),'r*');
   plot(ending(i)/(N/10),envelope(ending(i)),'ro');
   %% 确定index1 类型 1或者2
   o1=length(index(find(rem(index,2)~=0)));
      o2=length(index(find(rem(index,2)==0)));
      if o1>o2
          index1=1;
      else 
          if o1==o2
              if rem(index(1),2)~=0
                   index1=1;
              else
                   index1=2;
              end
              
          else
             index1=2; 
          end 
      end
    if rem(i-index1,2)==0
        if i~=1
       text(peak(i)/(N/10),envelope(peak(i))*1.03,'S2')
        if i~=1 && i~=length(peak)
            PCG(k).s2start = start(i);
            PCG(k).s2end = ending(i);
            PCG(k).s2peak = peak(i);
            PCG(k).s2H = envelope(peak(i));
        end
        end
    else
       text(peak(i)/(N/10),envelope(peak(i))*1.03,'S1')
        if k~=0
            PCG(k).ns1start = start(i);
        end
        if i~=length(peak) && i~=length(peak)-1
            k = k + 1;
            PCG(k).s1start = start(i);
            PCG(k).s1end = ending(i);
            PCG(k).s1peak = peak(i);
            PCG(k).s1H = envelope(peak(i));
        end
    end
end
% for i=1:length(peak)
%     if i==1
%         av1=peak(i+1)-peak(i);
%         av2=peak(i+2)-peak(i+1);
%         if av1<=av2
%             str(i)=1;
%         else
%              str(i)=2;
%         end
%     end
%     
%     if i==2||i==length(peak)
%        if str(i-1)==1; 
%            str(i)=2;
%        else
%            str(i)=1;
%        end
%     end
%     
%     if i>=3 && i<=length(peak)-1
%        av1=peak(i)-peak(i-1);
%        av2=peak(i+1)-peak(i); 
%        if av1<=av2 && str(i-1)==1
%            str(i)=2;
%        else
%            str(i)=1;
%        end
%     end
%     if str(i)==1
%         text(peak(i)/(N/10),envelope(peak(i))*1.03,'S1'); 
%     else
%         text(peak(i)/(N/10),envelope(peak(i))*1.03,'S2');
%     end
% end
% subplot(212)
% t1=(1:length(yyy))/(length(yyy)/10);
% plot(t1,yyy)
        