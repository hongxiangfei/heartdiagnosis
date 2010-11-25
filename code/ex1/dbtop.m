function p = dbtop(db,db0)
if nargin < 2 
    db0 = 1;
end
p = exp(db/10*log(10)) * db0;