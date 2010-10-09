function db=ptodb(p,p0)
if nargin < 2
    p0 = 1;
end
temp = 0;
if(sum(p==0)~=0)
    temp = 0.0001;
end
db = 10 * log10(p/p0+temp);

