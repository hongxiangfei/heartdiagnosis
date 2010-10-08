function [Hr,w,P,L] = Ampl_res(h);
%
% function [Hr,w,P,L] = Ampl_res(h)
% Computes Amplitude response Hr(w) and its polynomial P of order L,
% given a linear-phase FIR filter impulse response h.
% The type of filter is determined automatically by the suroutine.
%
% Hr = Amplitude Response
% w = Frequence between [0 pi] over which Hr is computed
% P = Polynomial coefficients
% L = Order of P
% h = Linear Phase filter impulse response
%
M = length(h);
if rem(M,2)==1
   if all(h(1:(M-1)/2)==h(M:-1:(M+3)/2)) [Hr,w,P,L] = Hr_type1(h);
   elseif all(h(1:(M-1)/2)==-h(M:-1:(M+3)/2)) & h((M+1)/2)==0, [Hr,w,P,L] = Hr_type3(h); 
       else disp('not a linear-phase filter, check h'), break, end
elseif all(h(1:M/2)==h(M:-1:M/2+1)); [Hr,w,P,L] = Hr_type2(h);
   elseif all(h(1:M/2)==-h(M:-1:M/2+1)); [Hr,w,P,L] = Hr_type4(h);
       else disp('not a linear-phase filter, check h'), break, end
end