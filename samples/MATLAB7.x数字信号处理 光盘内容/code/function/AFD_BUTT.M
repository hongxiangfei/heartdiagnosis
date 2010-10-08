function [b,a] = afd_butt(Wp,Ws,Rp,As);
% 巴特沃斯型模拟低通滤波器设计
% -----------------------------------------
% [b,a] = afd_butt(Wp,Ws,Rp,As);
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

N = ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(Wp/Ws)));
fprintf('\n*** Butterworth Filter Order = %2.0f \n',N)
OmegaC = Wp/((10^(Rp/10)-1)^(1/(2*N)));
[b,a]=u_buttap(N,OmegaC);

