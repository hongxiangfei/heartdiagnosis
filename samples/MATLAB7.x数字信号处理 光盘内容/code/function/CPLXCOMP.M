function I = cplxcomp(p1,p2)
%  I = cplxcomp(p1,p2)
%  �Ƚ���������ͬ������Ԫ�ص�(����)�в�ͬ�±�ĸ�����.
%  �������������CPLXPAIR ����֮���Ա�����Ƶ�ʼ�������
%  ������Ӧ����������:
%      p2 = cplxpair(p1)
%
I=[];
for j=1:1:length(p2)
    for i=1:1:length(p1)
	if (abs(p1(i)-p2(j)) < 0.0001)
	   I=[I,i];
        end
    end
end
I=I';
