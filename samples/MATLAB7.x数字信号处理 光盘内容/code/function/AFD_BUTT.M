function [b,a] = afd_butt(Wp,Ws,Rp,As);
% ������˹��ģ���ͨ�˲������
% -----------------------------------------
% [b,a] = afd_butt(Wp,Ws,Rp,As);
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

N = ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(Wp/Ws)));
fprintf('\n*** Butterworth Filter Order = %2.0f \n',N)
OmegaC = Wp/((10^(Rp/10)-1)^(1/(2*N)));
[b,a]=u_buttap(N,OmegaC);

