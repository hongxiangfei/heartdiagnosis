function [b,a] = afd_chb1(Wp,Ws,Rp,As);
% �б�ѩ��-1��ģ���ͨ�˲������
% -----------------------------------------
% [b,a] = afd_chb1(Wp,Ws,Rp,As);
%  b = Ha(s) ���ӵ�ϵ��
%  a = Ha(s) ��ĸ��ϵ��
% Wp = �Ի���/��Ϊ��λ��ͨ����ԵƵ��; Wp > 0
% Ws = �Ի���/��Ϊ��λ�������ԵƵ��; Ws > Wp > 0
% Rp = ͨ���е����������+dB��; (Rp > 0)
% As = ���˥����+dB��; (As > 0)
%
if Wp <= 0
        error('ͨ����Ե������� 0')
end
if Ws <= Wp
        error('�����Ե�������ͨ����Ե')
end
if (Rp <= 0) | (As < 0)
        error('ͨ�����������˥���������0')
end

ep = sqrt(10^(Rp/10)-1);
A = 10^(As/20);
OmegaC = Wp;
OmegaR = Ws/Wp;
g = sqrt(A*A-1)/ep;
N = ceil(log10(g+sqrt(g*g-1))/log10(OmegaR+sqrt(OmegaR*OmegaR-1)));
fprintf('\n*** �б�ѩ��-1 �˲����״� = %2.0f \n',N)
[b,a]=u_chb1ap(N,Rp,OmegaC);

