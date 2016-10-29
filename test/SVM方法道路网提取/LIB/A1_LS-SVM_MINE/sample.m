
function a = sample(m,n )
if(m<n)
    error('m must larger than n');
end
A=randperm(m);
a=A(1:n);
 