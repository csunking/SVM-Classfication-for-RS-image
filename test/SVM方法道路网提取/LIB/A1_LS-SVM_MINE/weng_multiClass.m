
% multicalss classfication example from data to end.
% Rrviewed by WENG, 2015-1-2 1750
% Serial No 150102-Matlab-01(LS-SVM classification for multiclass type.)
% Copyright (c) 2015,  

clc;clear all;

% test data
TestData=importdata('test.data');
Xt_label=TestData(:,1);
Xt_f=TestData(:,2:end);
clear TestData;
Xt_NumPoints=size(Xt_label,1);

% train data
TrainData=importdata('train.data');
X_f=TrainData(:,2:end);
X_label=TrainData(:,1);
clear TrainData;
X_feature_dimension=size(X_f,2);

% acc=zeros(5,1);
% time=zeros(5,1);
% for round=1:5
X_train=zeros(1000,X_feature_dimension);
y_train=zeros(1000,1);
for i=1:10
    temp=find(X_label==(i-1));
    s=size(temp,1);
    % returns a vector containing a random permutation of the integers 1:N.
    add_rp=randperm(s);
    add_rp_sub=add_rp(1:100);
    X_train((i-1)*100+1:i*100,:)=X_f(temp(add_rp_sub),:);
    y_train((i-1)*100+1:i*100)=(i-1)*ones(100,1);
    clear t1 s ra k
end
t1=cputime;
model = initlssvm(X_train,y_train,'c',[],[],'RBF_kernel');
model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'},'code_OneVsAll');
model = trainlssvm(model);
yt = simlssvm(model,Xt_f);
t=yt-Xt_label;
Accurancy=size(find(t==0),1)/Xt_NumPoints;
fprintf(1,'the precision is %2.3f%%',Accurancy);

t2=cputime;
time=t2-t1;
fprintf(1,'Tuning time %i \n',time);
fprintf(1,'Accuracy: %2.2f\n',Accurancy);

% end
% mean_time=mean(time);
% mean_acc=mean(Accurancy);
% result save
% save mean_time mean_time
% save mean_acc mean_acc