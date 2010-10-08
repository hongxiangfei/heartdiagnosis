%根据计算出来的PCG结构体，可以计算很多特征值，
%例如心率，s1时限，s2时限，s1峰值，s2峰值等等
%注意：所有特征都是几个心动周期的平均值
function [hrate,s1h,s1H,s2h,s2H]=features(PCG,Fs)
n=length(PCG);
sum_hrate = 0;
sum_s1h = 0;
sum_s1H = 0;
sum_s2h = 0;
sum_s2H = 0;
for i=1:n
    sum_hrate = sum_hrate + PCG(i).ns1start-PCG(i).s1start;
    sum_s1h = sum_s1h + PCG(i).s1end - PCG(i).s1start;
    sum_s1H = sum_s1H + PCG(i).s1H;
    sum_s2h = sum_s2h + PCG(i).s2end - PCG(i).s2start;
    sum_s2H = sum_s2H + PCG(i).s2H;
end
hrate = 60/(sum_hrate/n/Fs);
s1h = sum_s1h/n/Fs;
s1H = sum_s1H/n;
s2h = sum_s2h/n/Fs;
s2H = sum_s2H/n;
