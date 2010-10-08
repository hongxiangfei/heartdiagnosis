clear  all;
close  all
azi_num=2000;
fr=1000;
lamda0=0.005;
sigmav=1.0;
sigmaf=2*sigmav/lamda0;
rand(‘state’,sum(100*clock));
d1=rand(1,azi_num);
rand(‘state’,7*sum(100*clock)+3);
d2=rand(1,azi_num);
xi=2*sqrt(-2*log(d1)).*cos(2*pi*d2);
xq=2*sqrt(-2*log(d1)).*sin(2*pi*d2);
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
%生成高斯谱杂波
    xxi=conv(b,xi);
    xxq=conv(b,xq);
xxi=xxi(coe_num*2+1:azi_num+coe_num*2);
xxq=xxq(coe_num*2+1:azi_num+coe_num*2);
xisigmac=std(xxi);
ximuc=mean(xxi);
yyi=(xxi-ximuc)/xisigmac;
xqsigmac=std(xxq);
xqmuc=mean(xxq);
yyq=(xxq-xqmuc)/xqsigmac;
sigmac=1.2;    %杂波的标准差
yyi=sigmac*yyi;%使瑞利分布杂;
yyq=sigmac*yyq;
ydata=yyi+j*yyq;
figure(2);
 subplot(2,1,1),plot(real(ydata));  title('瑞利杂波时域波形,实部');
 subplot(2,1,2),plot(imag(ydata));  title('瑞利杂波时城波形,虚部');
 num=100;    %求概率密度函致的参数
maxdat=max(abs(ydata));
mindat=min(abs(ydata));
NN=hist(abs(ydata),num);
xpdf1=num*NN/((sum(NN))*(maxdat-mindat));
xaxis1=mindat:(maxdat-mindat)/num:maxdat-(maxdat-mindat)/num;
th_val=(xaxis1./sigmac.^2).*exp(-xaxis1.^2./(2*sigmac.^2));

figure(3);plot(xaxis1,xpdf1);
hold,plot(xaxis1,th_val,':r');
title('杂波幅度分布');xlabel('幅度');ylabel('概率密度');
signal=ydata;
signal=signal-mean(signal);
figure(4),M=256;
psd_dat=pburg(real(signal),32,M,fr);
psd_dat=psd_dat/(max(psd_dat));
freqx=0:0.5*M;
freqx=freqx*fr/M;
plot(freqx,psd_dat);title('杂波频谱');xlabel('频率（Hz)');ylabel('功率谱密度');
powerf=exp(-freqx.^2/(2*sigmaf.^2));
hold;plot(freqx,powerf,':r');
