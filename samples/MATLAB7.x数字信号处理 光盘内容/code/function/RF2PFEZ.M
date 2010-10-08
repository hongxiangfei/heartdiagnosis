function [R,p,C] = rf2pfez(b,a);
%在 z域中由有理函数作部分分式扩展
% -------------------------------------------------------------
% [R,p,C] = rf2pfez(b,a)
%  R =  p向量中各极点的留数行向量
%  p = 包含有理函数极点(a的根)的行向量
%  C = (M-N) 长(或零长)的包含多项式系数的向量
%  b = 有理函数的分子多项式系数 [b0,b1,...,bM],
%  a = 有理函数的分母多项式系数 [a0,a1,...,aN] ,
%
b = b/a(1); a = a/a(1);
b = fliplr(b); a = fliplr(a);
[R,p,C] = residue(b,a);
C = fliplr(C);
[b1,a1] = residue(R,p,[]);
b1 = fliplr(b1); a1 = fliplr(a1);
[R,p,k] = residue(b1,a1);
R = R'; p = p';
