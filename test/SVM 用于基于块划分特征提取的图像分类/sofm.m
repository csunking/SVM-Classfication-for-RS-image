function wvctor = sofm(FR)                          
%Cohonen��������㷨
%��������Ŀsamcout
%������ά��dim
%�������ĵ���Ŀclucout

[samcout, dim] = size(FR) ;  
dvctor = FR ;
% %�������samcout��dim ά��������
% dvctor = ceil(rand(samcout, dim)*(samcout));
% 
% plot3(dvctor(:,1),dvctor(:,2),dvctor(:,3),'b.');
% hold on;


% %�����ʼ��samcout��100ά����Ȩ����
clucout = 200;
randI = randperm(samcout);
if (samcout < 200)
    clucout = samcout ;
end

for i = 1:clucout
    wvctor(i, :) = FR(randI(i), :) ;
end

wvctor = wvctor' ;
% wvctor = ceil(rand(dim, clucout)*(samcout));
% plot3(wvctor(1,:),wvctor(2,:),wvctor(3,:),'r*');
% hold on;

%ȷ����ʼѧϰ�ʺ�ѧϰ����С��
rate1max=0.2;   
rate1min=0.05;

%ȷ����ʼ����뾶������뾶��ֵֹ
r1max=5;         
r1min=0.8;

%ȷ������������
maxgen=2000;



%clucout�������Ԫ�ڵ�����
k=1;
for j=1:clucout
   ajact(k,:)=[1,j];
   k=k+1;
end

for i=1:maxgen
    
    %ÿ�ε�������Ӧ�޸�ѧϰ�ʺ�����뾶
    rate1=rate1max-i/maxgen*(rate1max-rate1min);
    r1   =r1max   -i/maxgen*(r1max-r1min);
    
    %���ѡ��һ���������ݣ�����������ÿһ������������ŷʽ����
    k = unidrnd(samcout);  
    one = dvctor(k,:);
    vdist = dist(one, wvctor);
    [mindist, index] = min(vdist);
  
    %��������Χ�ڵ���Ԫ
    nodeindex=find(dist([1,index],ajact')<r1);
   
    %�Գ�ʼȨֵw�����޸�
   for j=1:length(nodeindex)
           wvctor(:,nodeindex(j))=wvctor(:,nodeindex(j))+rate1*(one'-wvctor(:,nodeindex(j)));
   end
end

wvctor = round(wvctor);
% plot3(wvctor(1,:),wvctor(2,:),wvctor(3,:),'g*');