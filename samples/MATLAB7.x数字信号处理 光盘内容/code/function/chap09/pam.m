funtion sp=pam(t,fc,fp,fs,tao,pha)
%该程序是用来产生脉冲调制信号（PAM）的
%参数t是所要产生脉冲幅度调制信号的时间，单位为s
%参数fc为脉内信号的频率，单位为Hz
%参数fp为脉冲信号的频率，单位为H
%参数fs为采样时钟频率，单位为Hz
%参数tao为脉冲信号的占空比，单位为%
%参数pta为信号的初始相位，单位为rad
if nargin <=6  %    如果不输入tao 和pha,
    tao=50;
        pha=0;
    end;
 n=0:1/fs:1/fp;
 tn=0:1/fs:t;
 m=t/(1fp);
 spt=(square(2*pi*fp*n)+1)/2;
 st=cos(2*pi*fc*n);
 sq1=st.*spt;
 sp=repmat(sq1,1,m);
