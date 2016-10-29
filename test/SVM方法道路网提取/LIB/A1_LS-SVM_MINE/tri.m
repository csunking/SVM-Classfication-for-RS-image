% function Yout= tri(gam,sig2,U,L,Y,p)
a=importdata('wine.data');
k1=[];
k2=[];
k3=[];
for i=1:size(a,1)
    if(a(i,1)==1)
        k1=[k1
            a(i,:)];
    elseif(a(i,1)==2)
        k2=[k2
            a(i,:)];
    else
        k3=[k3
            a(i,:)];
    end
end
y1=k1(:,1);
x1=k1(:,2:size(k1,2));
y2=k2(:,1);
x2=k2(:,2:size(k2,2));
x11=x1(1:10,:);
y11=y1(1:10);
x22=x2(1:10,:);
y22=y2(1:10);
L=[x11
    x22];
Y=[y11
    y22];
    gam=10;
    sig2=0.2;
    U=[x1(11:size(x1,1),:)
        x2(11:size(x2,1),:)];
    p=0.8;
[r,c]=size(L);
n=floor(p*r);
x=1:r;
in=bootsp(x,3);
[ur,uc]=size(U);
dY=zeros(ur,3);
pY=cell(1,3);
type = 'classification';
gam1=gam;
sig21=sig2;
l=1;
  al1=cell(1,3);
  al2=cell(1,3);
  pb1=[];
  pb2=[];
  dpL=cell(1,3);
  X=cell(1,3);
  sY=cell(1,3);
  alpha=cell(1,3);
   e=zeros(1,3);
    update=zeros(1,3);
     prem=zeros(1,3);
     pst=zeros(1,4);
       psize=zeros(1,3);
          dL=cell(1,3);
     dpY=cell(1,3);
     clear dpL X sY alpha dL dpY al1 al2;
     al1{1}=1;
    al2{1}=2;
  for i=1:3
   eval(['X',num2str(i),'=','L(in(1:n,i),:)',';']);
   eval(['Y',num2str(i),'=','Y(in(1:n,i),:)',';']);
   eval(['pe',num2str(i),'=','0.5',';']);
   eval(['pl',num2str(i),'=','0',';']);
  end                        
pe=[pe1,pe2,pe3];
pl=[pl1,pl2,pl3];
[alpha1,b1]=trainlssvm({X1,Y1,type,gam1,sig21,'RBF_kernel','preprocess'});
[alpha2,b2]=trainlssvm({X2,Y2,type,gam1,sig21,'RBF_kernel','preprocess'});
[alpha3,b3]=trainlssvm({X3,Y3,type,gam1,sig21,'RBF_kernel','preprocess'});
b=[b1,b2,b3];
for i=1:3
    eval(['X{i}','=','X',num2str(i),';']);
    eval(['sY{i}','=','Y',num2str(i),';']);
    eval(['alpha{i}','=','alpha',num2str(i),';']);
end
    while(~((comp(al1{1},al2{1}))&&(comp(al1{2},al2{2}))&&(comp(al1{3},al2{3}))))
        for i=1:3
            if(i==1)
                j=2;
                k=3;
            elseif(i==2)
                j=1;
                k=3;
            else
                j=1;
                k=2;
            end
         eval(['L',num2str(i),'=','[ ]',';']);
         eval(['update',num2str(i),'=','0',';']);
         if(l==1)
         eval(['e',num2str(i),'=','MeasureError(X{j},sY{j},X{k},sY{k},alpha{j},alpha{k},b(j),b(k),L,Y,gam1,sig21)',';']);
         else
         eval(['e',num2str(i),'=','MeasureError(dpL{j},pY{j},dpL{k},pY{k},al2{j},al2{k},pb2(j),pb2(k),L,Y,gam1,sig21)',';']);
         end
         if (i==1)
             update(1)=update1;
             e(1)=e1;
         elseif(i==2)
              update(2)=update2;
             e(2)=e2;
         else
              update(3)=update3;
             e(3)=e3;
         end
         h=zeros(ur,2);
      if(e(i)<pe(i))
          if (l==1)
         eval(['h(:,1)','=','simlssvm({X{j},sY{j},type,gam1,sig21,''RBF_kernel'',''preprocess''},{alpha{j},b(j)},U)',';']);
         eval(['h(:,2)','=','simlssvm({X{k},sY{k},type,gam1,sig21,''RBF_kernel'',''preprocess''},{alpha{k},b(k)},U)',';']); 
          else
         eval(['h(:,1)','=','simlssvm({dpL{j},pY{j},type,gam1,sig21,''RBF_kernel'',''preprocess''},{al2{j},b(j)},U)',';']);
         eval(['h(:,2)','=','simlssvm({dpL{k},pY{k},type,gam1,sig21,''RBF_kernel'',''preprocess''},{al2{k},b(k)},U)',';']);  
          end
      end
          dY=[];
          dU=[];
          psize(i)=0;
     for m=1:ur
      if(h(m,1)==h(m,2))
          dU=[dU' U(m,:)']';
          dY=[dY h(m,1)];
       psize(i)=psize(i)+1;
      end
     end
     dY=dY';
     eval(['L',num2str(i),'=','dU ',';']);
     eval(['dY',num2str(i),'=','dY ',';']);  
       if (i==1)
            dL{1}=L1;
              dpY{1}=dY1;
         elseif(i==2)
             dL{2}=L2;
             dpY{2}=dY2;
         else
             dL{3}=L3;
             dpY{3}=dY3;
       end
    if(pl(i)==0)
        pl(i)=floor(e(i)/(pe(i)-e(i))+1);
    end
    i
    pl(i)
    psize(i)
    if(pl(i)<psize(i))
       k1= e(i)*psize(i)
       k2= pe(i)*pl(i)
        if((e(i)*psize(i))<(pe(i)*pl(i)))
            update(i)=1;
        elseif(pl(i)>=(e(i)/(pe(i)-e(i))))
                prem(i)=ceil(pe(i)*pl(i)/e(i)-1);
              sam=sample(psize(i),prem(i));  
              t1=dL{i};
              t1(sam,:)=[];
              dL{i}=t1;
              t2=dpY{i};
              t2(sam,:)=[];
              dpY{i}=t2;
              update(i)=1;
        end
    end
        end
        t=l
        update
        for i=1:3
            if(update(i)==1)
              temp1=dL{i};
              temp2=dpY{i};
              pL=[temp1' L']'; 
              pdY=[temp2' Y']';
              pY{i}=pdY;
              dpL{i}=pL;
              eval(['[talpha tb]=trainlssvm({pL,pdY,type,gam1,sig21,''RBF_kernel'',''preprocess''})',';']);
            pe(i)=e(i);
            pl(i)=psize(i);      
            if(l==1)
              al2{i}= talpha;
              pb2=[pb2 tb];
            else
                al1=al2;
                pb1=pb2;
                al2{i}=talpha;
                pb2=[pb2 tb];
            end                     
             end
        end
        pe
        pl
       l=l+1; 
       if(update==0)
           break;
       end
    end
     ph=zeros(ur,3);
    for i=1:3
        i
        size(dpL{i})
        size(pY{i})
       ph(:,i)=simlssvm({dpL{i},pY{i},type,gam1,sig21,'RBF_kernel','preprocess'},{al2{i},b(i)},U);
    end
    dsum=sum(ph,2);
   Yout=sign(dsum)
