clc
clear all
a=importdata('test.data');
testlabels=a(:,1);
testfea=a(:,2:end);
st=size(testlabels,1);
clear a
a=importdata('train.data');
ta=a(:,2:end);
b=a(:,1);
s1=size(ta,2);
% acc=zeros(5,1);
% time=zeros(5,1);
% for round=1:5
trainfea=zeros(1000,s1);
trainlabels=zeros(1000,1);
for i=1:10
t1=find(b==(i-1));
s=size(t1,1);
ra=randperm(s);
k=ra(1:100);
trainfea((i-1)*100+1:i*100,:)=ta(t1(k),:);
trainlabels((i-1)*100+1:i*100)=(i-1)*ones(100,1);
clear t1 s ra k
end
t1=cputime;
model = initlssvm(trainfea,trainlabels,'c',[],[],'RBF_kernel');
model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'},'code_OneVsAll');
model = trainlssvm(model);
y = simlssvm(model,testfea);
t=y-testlabels;
acc=size(find(t==0),1)/st
t2=cputime;
time=t2-t1
% end
mean_time=mean(time);
mean_acc=mean(acc);
fprintf(1,'Tuning time %i \n',time);
fprintf(1,'Accuracy: %2.2f\n',acc);
% save mean_time mean_time
% save mean_acc mean_acc