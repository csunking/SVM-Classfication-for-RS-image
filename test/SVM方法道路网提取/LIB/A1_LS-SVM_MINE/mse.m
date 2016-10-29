function perf=mse(e)
%
% calculate the mean squared error of the given errors
% 
%  'perf = mse(E);'
%
% see also:
%    mae, linf, trimmedmse
%

% Copyright (c) 2002,  KULeuven-ESAT-SCD, License & help @ http://www.esat.kuleuven.ac.be/sista/lssvmlab


perf = sum(sum(e.^2)) / numel(e);