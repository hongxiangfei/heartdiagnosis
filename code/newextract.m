function PCG=newextract(envelope,t)

N=length(envelope);
Fs = 1/(t(2)-t(1));
hold on
maximum=find(diff(sign(diff(envelope)))==-2)+1;%极大值点的index
maxth=max(envelope(maximum))*0.2;

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
        if(envelope(maximum(i))>maxth)
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
              ratio = envelope(peak(i)) / envelope(peak(i+1));
              if ratio >0.9 && ratio < 10/9  % 差不多大，选择第一个
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
%恢复漏检的峰值
mininterval = min(interval);
minheight = min(envelope(peak));
i=1;
while i<=length(interval)
    if interval(i) > 2.2 * mininterval
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
        if envelope(extra_peak) * 2 > minheight && rate1 > 0.7 && rate1 < 10/7 && rate2 > 0.7 && rate2 < 10/7 && min(extra_peak-peak(i),peak(i+1)-extra_peak) > low_level 
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
index = find(interval==max(interval)) ; 
k=0;
for i=1:length(peak)
    plot(peak(i)/Fs,envelope(peak(i)),'rs')
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
   plot(start(i)/Fs,envelope(start(i)),'r*');
   plot(ending(i)/Fs,envelope(ending(i)),'ro');
    if rem(i-index,2)==0
       text(peak(i)/Fs,envelope(peak(i))*1.03,'S2')
        if i~=1 && i~=length(peak)
            PCG(k).s2start = start(i);
            PCG(k).s2end = ending(i);
            PCG(k).s2peak = peak(i);
            PCG(k).s2H = envelope(peak(i));
        end
    else
       text(peak(i)/Fs,envelope(peak(i))*1.03,'S1')
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

        