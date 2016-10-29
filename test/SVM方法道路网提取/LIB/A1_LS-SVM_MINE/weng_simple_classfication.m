clc;clear;
X = 2.0*rand(30,2)-1;
y = sign( sin(X(:,1))+X(:,2) );
Xt = 2.0*rand(150,2)-1;
yt_original=sign(sin(Xt(:,1))+Xt(:,2));

gam=10;
sig2=0.2;
% alpha:    N x m matrix with support values of the LS-SVM
% b:        1 x m vector with bias term(s) of the LS-SVM
[alpha,b]=trainlssvm({X,y,'classification',gam,sig2,'RBF_kernel','preprocess'});    % ÑµÁ·
yt=simlssvm({X,y,'classification',gam,sig2,'RBF_kernel','preprocess'},{alpha,b},Xt); % ²âÊÔ


add_k_upper0=find(yt_original>0);
add_k_lower0=find(yt_original<0);
TestNum=size(Xt,1);
j1=find(yt(add_k_upper0,:)==1);
j2=find(yt(add_k_lower0,:)==-1);
sk=size(j1,1);
jk=size(j2,1);
Precisions=(sk+jk)/TestNum;
fprintf(1,sprintf('the precisions of this classificion:%f%%',100*Precisions));