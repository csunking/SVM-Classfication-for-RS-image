
% multicalss classfication example from data to end.
% Rrviewed by WENG, 2015-1-2 1750
% Serial No 150102-Matlab-01(LS-SVM classification for multiclass type.)
% Copyright (c) 2015,  

function main(PROJECTNAME)

if nargin<1,
clc; 
clear all; %#ok<CLFUN>
PROJECTNAME='fdoa1_rs1_rg';
end

% data parameters
if ~exist(sprintf('..\\..\\..\\..\\Main\\road_v4\\data\\%s_IMG_normalize.mat',PROJECTNAME),'file')
    IMG=double(imread(sprintf('..\\..\\..\\..\\Main\\road_v4\\data\\%s.tif',PROJECTNAME),'tif'))./255.0;                                     %resample file name
    [M,N,P]=size(IMG);
    IMG=double(IMG);
    % 0值处理
    tmp=IMG;
    tmp(IMG==0)=mean(IMG(:));
    min_value=min(tmp(:));
    max_value=max(tmp(:));
    
    IMG_normalize=zeros(M,N,P);
    for i=1:P
        IMG_normalize(:,:,i)=(tmp(:,:,i)-min_value)./(max_value-min_value);
    end
    clear tmp IMG;
    save(sprintf('..\\..\\data\\%s_IMG_normalize.mat',PROJECTNAME),'IMG_normalize');    
else
    load(sprintf('..\\..\\data\\%s_IMG_normalize.mat',PROJECTNAME)); % IMG_normalize
end
[M,N,P]=size(IMG_normalize);

classNames={'road';'buildings';'peoper square';};% 'others'
calssNum=size(classNames,1);
BolockSize=5;
EveryClassSampleNum=10;

% data formatting
if ~exist(sprintf('..\\..\\data\\%s_TrainDataSet.mat',PROJECTNAME),'file'),
    TrainDataSet = getDataSet(IMG_normalize,classNames,BolockSize,EveryClassSampleNum );
    save(sprintf('..\\..\\data\\%s_TrainDataSet.mat',PROJECTNAME),'TrainDataSet');
else
    load(sprintf('..\\..\\data\\%s_TrainDataSet.mat',PROJECTNAME));
end
everyImageSize=BolockSize^2;
trainData_PearCN=EveryClassSampleNum*everyImageSize;
trainData_Num=calssNum*trainData_PearCN;
Y_label=zeros(trainData_Num,1);     % label(tarin data label)
X_Data=zeros(trainData_Num,P);      % Data
for i=1:calssNum,
    Y_label((trainData_PearCN*(i-1)+1):(trainData_PearCN*i))=i;
    temp_clas=TrainDataSet(i,:);
    Cache_PerClassImage=zeros(trainData_PearCN,P);
    for subimg_j=1:EveryClassSampleNum,
        subimg=temp_clas{subimg_j}; % cell to matrix
        subimg=reshape(subimg,everyImageSize,P);
        Cache_PerClassImage((everyImageSize*(subimg_j-1)+1):(everyImageSize*subimg_j),:)=subimg;
    end
    X_Data((trainData_PearCN*(i-1)+1):(trainData_PearCN*i),:)=Cache_PerClassImage; % train data(feature)
end
clear temp_clas Cache_PerClassImage everyImageSize subimg;
Xt_f=reshape(IMG_normalize,M*N,P);    % test data


% svm run process
% ----------------------------------------------------------------------------------------
t1=cputime;
try
model_svm = initlssvm(X_Data,Y_label,'c',[],[],'RBF_kernel');
model_svm = tunelssvm(model_svm,'simplex','crossvalidatelssvm',{10,'misclass'},'code_OneVsAll');
model_svm = trainlssvm(model_svm);
catch
addpath(pwd,strcat(pwd,'\LIB\A1_LS-SVM_MINE'));
end
yt = simlssvm(model_svm,Xt_f);


% result of classficated display
% ----------------------------------------------------------------------------------------
IMG_classficated=reshape(yt,M,N);
add=IMG_classficated<0;
IMG_classficated(add)=0; % unclassfied class is define to 0;
figure,imshow(IMG_classficated,[],'colormap',prism,'InitialMagnification','fit');
title('The final classficated images');
save IMG_classficated IMG_classficated
% Verify the accuracy
% t=yt-Xt_label;
% Accurancy=size(find(t==0),1)/Xt_NumPoints;
% fprintf(1,'Accuracy: %2.2f\n',Accurancy);
t2=cputime;
time=t2-t1;
fprintf(1,'Tuning time %i \n',time);



% 对初始的分割结果进行优化处理 2015-10-19
% ----------------------------------------------------------------------------------------
IMG_road=IMG_classficated==1;
IMG_gray=rgb2gray(IMG_normalize(:,:,[22,11,9]));
h = fspecial('gaussian',[10,10], 0.5);
IMG_gau = imfilter(IMG_gray, h);
IMG_edge= edge(IMG_gau,'canny');
figure,subplot(1,2,1),imshow(IMG_road,[]);title('初步的SVM道路网分类结果')
IMG_road(IMG_edge)=0;
subplot(1,2,2);imshow(IMG_road,[]),colormap copper,title('道路初始分割结果，进一步分割黏连块的效果');
save(sprintf('..\\..\\data\\%s_IMG_road.mat',PROJECTNAME),'IMG_road')

