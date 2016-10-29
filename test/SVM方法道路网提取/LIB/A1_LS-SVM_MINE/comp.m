 function    out=comp(in1,in2)
        s1=size(in1,1);
        s2=size(in2,1);
        k=0;
        out=0;
        if(s1~=s2)
            out=0;
        else
            for i=1:s1
                if(in1(i)==in2(i))
                    k=k+1;
                end
            end
            if(k==s1)
                out=1;
            end
        end
 end
 
