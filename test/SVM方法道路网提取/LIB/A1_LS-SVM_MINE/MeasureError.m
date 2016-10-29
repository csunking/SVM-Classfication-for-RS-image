 function e=MeasureError(X1,Y1,X2,Y2,a1,a2,b1,b2,L,Y,gam,sig2)
        type='classification';  
        gam1=gam;
        sig21=sig2;
        if((size(X1,1)~=size(Y1,1))||(size(X2,1)~=size(Y2,1)))
            error('dims are not matched');
        end
        h1=simlssvm({X1,Y1,type,gam1,sig21,'RBF_kernel','preprocess'},{a1,b1},L);
        h2=simlssvm({X2,Y2,type,gam1,sig21,'RBF_kernel','preprocess'},{a2,b2},L);
        s1=size(h1,1);
        s2=size(h2,1);
        j=0;
        k=0;
        if(s1==s2)
         for i=1:s1
             if (h1(i)==h2(i))
                 k=k+1;
             end
             if(h1(i)~=Y(i)&&h2(i)~=Y(i))
                 j=j+1;
             end
         end
        else
            error('the dim should be equal');
        end
          e=j/k; 
 end  