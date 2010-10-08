function [b,a] = afd_elip(Wp,Ws,Rp,As);
% ��Բ��ģ���ͨ�˲������
% --------------------------------------
% [b,a] = afd_elip(Wp,Ws,Rp,As);
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
k = Wp/Ws;
k1 = ep/sqrt(A*A-1);
capk = ellipke([k.^2 1-k.^2]); % Version 4.0 code
capk1 = ellipke([(k1 .^2) 1-(k1 .^2)]); % Version 4.0 code
N = ceil(capk(1)*capk1(2)/(capk(2)*capk1(1)));
fprintf('\n*** ��Բ�˲����״� = %2.0f \n',N)
[b,a]=u_elipap(N,Rp,As,OmegaC);
