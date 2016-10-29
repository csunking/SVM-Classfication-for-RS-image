function wvctor = sofm(FR)                          
%Cohonen网络聚类算法
%样本的数目samcout
%样本的维数dim
%聚类中心的数目clucout

[samcout, dim] = size(FR) ;  
dvctor = FR ;
% %随机产生samcout个dim 维的行向量
% dvctor = ceil(rand(samcout, dim)*(samcout));
% 
% plot3(dvctor(:,1),dvctor(:,2),dvctor(:,3),'b.');
% hold on;


% %随机初始化samcout个100维的列权向量
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

%确定初始学习率和学习率最小率
rate1max=0.2;   
rate1min=0.05;

%确定初始领域半径和领域半径截止值
r1max=5;         
r1min=0.8;

%确定最大迭代次数
maxgen=2000;



%clucout个输出神经元节点排序
k=1;
for j=1:clucout
   ajact(k,:)=[1,j];
   k=k+1;
end

for i=1:maxgen
    
    %每次迭代自适应修改学习率和领域半径
    rate1=rate1max-i/maxgen*(rate1max-rate1min);
    r1   =r1max   -i/maxgen*(r1max-r1min);
    
    %随机选择一个样本数据，计算样本和每一个竞争向量的欧式距离
    k = unidrnd(samcout);  
    one = dvctor(k,:);
    vdist = dist(one, wvctor);
    [mindist, index] = min(vdist);
  
    %计算邻域范围内的神经元
    nodeindex=find(dist([1,index],ajact')<r1);
   
    %对初始权值w进行修改
   for j=1:length(nodeindex)
           wvctor(:,nodeindex(j))=wvctor(:,nodeindex(j))+rate1*(one'-wvctor(:,nodeindex(j)));
   end
end

wvctor = round(wvctor);
% plot3(wvctor(1,:),wvctor(2,:),wvctor(3,:),'g*');