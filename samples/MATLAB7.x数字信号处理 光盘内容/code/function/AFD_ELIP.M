function [b,a] = afd_elip(Wp,Ws,Rp,As);
% 椭圆型模拟低通滤波器设计
% --------------------------------------
% [b,a] = afd_elip(Wp,Ws,Rp,As);
%  b = Ha(s) 分子的系数
%  a = Ha(s) 分母的系数
% Wp = 以弧度/秒为单位的通带边缘频率; Wp > 0
% Ws = 以弧度/秒为单位的阻带边缘频率; Ws > Wp > 0
% Rp = 通带中的振幅波动的+dB数; (Rp > 0)
% As = 阻带衰减的+dB数; (As > 0)
%
if Wp <= 0
        error('通带边缘必须大于 0')
end
if Ws <= Wp
        error('阻带边缘必须大于通带边缘')
end
if (Rp <= 0) | (As < 0)
        error('通带波动或阻带衰减必须大于0')
end

ep = sqrt(10^(Rp/10)-1);
A = 10^(As/20);
OmegaC = Wp;
k = Wp/Ws;
k1 = ep/sqrt(A*A-1);
capk = ellipke([k.^2 1-k.^2]); % Version 4.0 code
capk1 = ellipke([(k1 .^2) 1-(k1 .^2)]); % Version 4.0 code
N = ceil(capk(1)*capk1(2)/(capk(2)*capk1(1)));
fprintf('\n*** 椭圆滤波器阶次 = %2.0f \n',N)
[b,a]=u_elipap(N,Rp,As,OmegaC);
