L = -1*rand(30,2)-1;
Y = sign(sin(L(:,1))+L(:,2));
dL=cell(1,2);
gam=10,sig2=0.2;
type = 'classification';
[alpha1,b1]=trainlssvm({L,Y,type,gam,sig2,'RBF_kernel','preprocess'});
    U = -1*rand(150,2)-1;
           h=simlssvm({L,Y,type,gam,sig2,'RBF_kernel','preprocess'},{alpha1,b1},U)
            k=sin(U(:,1))+U(:,2);
     a=find(k>0);
     c=find(k<0);
     size(a,1)
     ur=size(U,1);
     b=ur-size(a,1)
     j1=find(h(a,:)==1);
     sk=size(j1,1)
       j2=find(h(c,:)==-1);
     jk=size(j2,1)
     per=(sk+jk)/ur 