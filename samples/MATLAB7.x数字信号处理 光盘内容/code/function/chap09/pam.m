funtion sp=pam(t,fc,fp,fs,tao,pha)
%�ó���������������������źţ�PAM����
%����t����Ҫ����������ȵ����źŵ�ʱ�䣬��λΪs
%����fcΪ�����źŵ�Ƶ�ʣ���λΪHz
%����fpΪ�����źŵ�Ƶ�ʣ���λΪH
%����fsΪ����ʱ��Ƶ�ʣ���λΪHz
%����taoΪ�����źŵ�ռ�ձȣ���λΪ%
%����ptaΪ�źŵĳ�ʼ��λ����λΪrad
if nargin <=6  %    ���������tao ��pha,
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
