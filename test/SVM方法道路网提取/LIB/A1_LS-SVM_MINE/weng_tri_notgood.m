
% function Yout= tri(gam,sig2,U,L,Y,p)
a=importdata('wine.data');
dataNumUtility=size(a,1);

% data organization
temp=a(:,1);
add_1=find(temp==1);
add_2=find(temp==2);
add_3=find(temp==3);
k1=a(add_1,:);
k2=a(add_2,:);
k3=a(add_3,:);

y1_label=k1(:,1);   x1=k1(:,2:end);
y2_label=k2(:,1);   x2=k2(:,2:end);
x1_sub=x1(1:10,:);  y1_sub=y1_label(1:10);
x2_sub=x2(1:10,:);  y2_sub=y2_label(1:10);
L=[x1_sub;x2_sub];
Y=[y1_sub;y2_sub];

x=1:size(L,1);
in=bootsp(x,3);                 %对x重新采样，length(x) * 3
U=[x1(11:end,:);x2(11:end,:)];
[U_rlength,~]=size(U);
dY=zeros(U_rlength,3);
pY=cell(1,3);

% parameter
type = 'classification';
gam1=10;
sig21=0.2;
l_=1;

clear dpL X sY alpha dL dpY al1 al2;
al1{1}=1;
al2{1}=2;
for i=1:3
    eval(['X',num2str(i),'=','L(in(1:end,i),:)',';']);
    eval(['Y',num2str(i),'=','Y(in(1:end,i),:)',';']);
    eval(['pe',num2str(i),'=','0.5',';']);
    eval(['pl',num2str(i),'=','0',';']);
    eval(['[alpha',num2str(i),',b',num2str(i),']=trainlssvm({','X',num2str(i),',Y',num2str(i),',type,gam1,sig21,''RBF_kernel'',''preprocess''});']);
end
pe=[pe1,pe2,pe3];
pl=[pl1,pl2,pl3];
b=[b1,b2,b3];
for i=1:3
    eval(['X{i}','=','X',num2str(i),';']);
    eval(['sY{i}','=','Y',num2str(i),';']);
    eval(['alpha{i}','=','alpha',num2str(i),';']);
end


j_vec=[2 1 1];
k_vec=[3 3 2];
pb1=[];
pb2=[];
e=zeros(1,3);
update=zeros(1,3);
prem=zeros(1,3);
psize=zeros(1,3);

while ~((comp(al1{1},al2{1}))&&(comp(al1{2},al2{2}))&&(comp(al1{3},al2{3}))),
    
    for i=1:3
        j=j_vec(i);
        k=k_vec(i);
        eval(['L',num2str(i),'=','[ ]',';']);
        eval(['update',num2str(i),'=','0',';']);
        if(l_==1)
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
        h=zeros(U_rlength,2);
        if(e(i)<pe(i))
            if (l_==1)
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
        for m=1:U_rlength
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
    t=l_
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
            if(l_==1)
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
    l_=l_+1;
    if(update==0)
        break;
    end
end

ph=zeros(U_rlength,3);
for i=1:3    
    size(dpL{i})
    size(pY{i})
    ph(:,i)=simlssvm({dpL{i},pY{i},type,gam1,sig21,'RBF_kernel','preprocess'},{al2{i},b(i)},U);
end
dsum=sum(ph,2);
Yout=sign(dsum);
