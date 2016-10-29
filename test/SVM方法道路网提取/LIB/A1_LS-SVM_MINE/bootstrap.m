N = 1000; % Size of your total set
Nsub = 8; % Size of the subset
nu = 0;

while(length(nu) < Nsub)
x = round(.5 + (N - eps(N+.5))*rand(1,10*Nsub));
[b1, nu, n1] = unique(x, 'first');
end

indexi = nu(1:Nsub) % Unique and random indexes for subset into
% the larger set.
