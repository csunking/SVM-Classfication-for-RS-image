function m = tbform(model,alpha)

%
% INTERNAL FUNCTION
%

% This function calculates the factor 'm' for simultaneous CI/PI using the
% tube formula based "m=sqrt(2log(kappa/(alpha*pi)))" on upcrossing theory:
%
% Rice, S. O. (1939). The distribution of the maxima of a random curve.
% American Journal of Mathematics 61: 409–16.

% Copyright (c) 2010,  KULeuven-ESAT-SCD, License & help @ http://www.esat.kuleuven.be/sista/lssvmlab


if nargin <= 1
    alpha = 0.05;
end

% version check
resp = which('quadgk');
if isempty(resp), imethod=@quad; else imethod=@quadgk; end

% only useful in 1D and no preprocessing
if  (size(model.xtrain,2) == 1 && model.preprocess(1)=='o')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Some initial calculation used later
    K = kernel_matrix(model.xtrain,model.kernel_type,model.kernel_pars);
    Z = pinv(K+eye(model.nb_data)./model.gam);
    c = sum(sum(Z));
    J = ones(model.nb_data)./c;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Calculation of the kappa coefficient in the tube formula
    kappa = imethod(@(x)fun1(model,x,Z,J),min(model.xtrain),max(model.xtrain));
    
    % Tube formula
    m = sqrt(2*log(kappa/(alpha*pi)));
    
else % better in higher dimensions
    S = smootherlssvm(model);
    kappa = (pi/2)*(trace(S)-1);
    m = sqrt(2*log(kappa/(pi*alpha)));
end


function I = fun1(model,x,Z,J)
L = smootherlssvm(model,x');
dL = fund(model,x',Z,J);
h = L*L';
I = diag(sqrt((h.*(dL*dL'))-(L*dL').^2)./h)';

function dL = fund(model,x,Z,J)
% Calculation of the elementwise derivites (analitically) of the
% smoother matrix
Kt = kernel_matrix(model.xtrain,model.kernel_type,model.kernel_pars,x);
omega = repmat(x,1,model.nb_data);
omega = omega - repmat(model.xtrain',size(omega,1),1);
dL = -((2/model.kernel_pars)*omega.*Kt')*(Z-Z*J*Z);