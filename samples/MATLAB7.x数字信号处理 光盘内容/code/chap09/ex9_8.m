clear all;
close all;
clc
azi_num=2000;
fr=1000;
lamda0=0.05;
sigmav=0.7;
sigmaf=2*sigmav/lamda0;
rand(‘state’,sum(100*clock));
d1=rand(1,azi_num);
rand(‘state’,7*sum(100*clock)+3);
d2=rand(1,azi_num);
xi=1*(sqrt(-2*log(d1)).*cos(2*pi*d2));
xq=2*(sqrt(-2*log(d1)).*sin(2*pi*d2));
coe_num=12;
for n=0:coe_num
    coeff(n+1)=2*sigmaf*sqrt(pi)*exp(-4*sigmaf^2*pi^2*n^2/fr^2)/fr;
end
for n=1:2*coe_num+1
    if n<=coe_num+1
        b(n)=1/2*coeff(coe_num+2-n);
    else
        b(n)=1/2*coeff(n-coe_num);
    end
end
xxi=conv(b,xi);
xxi=xxi(coe_num*2+1:azi_num+coe_num*2);
xxq=conv(b,xq);
xxq=xxq(coe_num*2+1:azi_num+coe_num*2);
xisigmac=std(xxi);
ximuc=mean(xxi);
yyi=(xxi-ximuc)/xisigmac;
xqsigmac=std(xxq);
xqmuc=mean(xxq);
yyq=(xxq-xqmuc)/xqsigmac;
p=1.5;
q=2.2;
sigmac=sqrt((q.^p)/2);
yyi=sigmac*yyi;
yyq=sigmac*yyq;
xdata=(yyi.*yyi+yyq.*yyq).^(1/p);
figure,plot(xdata);title('对数正态杂波时域波形');
%%%%%%%%%%%%%求概率密度函数的参数%%%%%%%%%%%%
num=100;
maxdat=max(abs(xdata));
mindat=min(abs(xdata));
NN=hist(abs(xdata),num);
xpdf1=num*NN/((sum(NN))*(maxdat-mindat));
xaxis1=mindat:(maxdat-mindat)/num:maxdat-(maxdat-mindat)/num;
%th_val=lognpdf(xaxis1,xpdf1);

%xpdf1=getnpdf(abs(xdata),num,maxdat,mindat);
%xaxis1=mindat:(maxdat-mindat)/num:maxdat-(maxdat-mindat)/num;
th_val=p*(xaxis1.^(p-1)).*exp(-(xaxis1/p).^p)./(q.^p);
figure,plot(xaxis1,xpdf1);
hold,plot(xaxis1,th_val,':r'),title('杂波幅度分布'),xlabel('幅度'),
ylabel('概率密度');
signal=xdata;
signal=signal-mean(xdata);
M=256;
psd_dat=pburg(real(signal),16,M,fr);
psd_dat=psd_dat/(max(psd_dat));
freqx=0:0.5*M;
freqx=freqx*fr/M;
figure,plot(freqx,psd_dat);
title('杂波频谱'),xlabel('频率（Hz）'),
ylabel('功率谱密度');
%%%%%%%% 理想高斯曲线%%%%%%%%%%%%
powerf=exp(-freqx.^2/(2*sigmaf.^2));
hold;
plot(freqx,powerf,':r');
