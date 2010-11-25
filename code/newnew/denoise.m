function s=denoise(x)

% 小波种类
wname='db6';

% 小波分解
[c,l]=wavedec(x,8,wname);
a8=appcoef(c,l,wname,8);
d8=detcoef(c,l,8);
d7=detcoef(c,l,7);
d6=detcoef(c,l,6);
d5=detcoef(c,l,5);
d4=detcoef(c,l,4);
d3=detcoef(c,l,3);
d2=detcoef(c,l,2);
d1=detcoef(c,l,1);

% d1:1500-3000HZ d2:750-1500HZ d3:375-750HZ d4:187.5-375HZ d5:93.75-187.5HZ
% d6:46.875-93.75HZ d7:23.4375-46.875HZ d8:12.71875-23.4375 a8:0-12.71875

c=[zeros(1,length(a8)+length(d8)) d7 d6 d5 zeros(1,length(d4)+length(d3)+length(d2)+length(d1))];

% 小波重构
s=waverec(c,l,'db6');

% 归一化
s=s/max(s);