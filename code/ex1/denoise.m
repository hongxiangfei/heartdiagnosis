function s=denoise(x)
wname='db6';
[c,l]=wavedec(x,5,wname);
a5=appcoef(c,l,wname,5);
d5=detcoef(c,l,5);
d4=detcoef(c,l,4);
d3=detcoef(c,l,3);
d2=detcoef(c,l,2);
d1=detcoef(c,l,1);
% d1:551-1102HZ d2:275-551HZ d3:138-275HZ d4:69-138HZ d5:34-69HZ a5:0-34Hz
% 4th and 5th level detail was kept£¨34-138Hz)
c=[zeros(length(a5),1);d5;d4;zeros(length(d3)+length(d2)+length(d1),1)];
s=waverec(c,l,'db6');
s=s/max(s);