function [b,a] = pfe2rfz(R,P,C)
%在 z域中作部分分式扩展所得有理函数
% --------------------------------------------------------------
% [b,a] = pfe2rfz(R,P,C)
%  b = 有理函数的分子多项式系数 [b0,b1,...,bM],
%  a = 有理函数的分母多项式系数 [a0,a1,...,aN] ,
%  R =  p向量中各极点的留数行向量
%  p = 包含有理函数极点(a的根)的行向量
%  C = (M-N) 长(或零长)的包含多项式系数的向量
%
R = R'; p = p';
[b1,a1]=residue(R,P,[]);
b1=fliplr(b1); a1=fliplr(a1);
[r,p,k]=residue(b1,a1);
[b,a]=residue(r,p,fliplr(C));
b=fliplr(b); a=fliplr(a);
b=real(b); a=real(a);
b=b/a(1); a=a/a(1);
