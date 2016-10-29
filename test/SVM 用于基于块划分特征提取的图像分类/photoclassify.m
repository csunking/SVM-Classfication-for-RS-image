%图像分类
clc;

FilePath = 'F:\JOBS\SVM_MRS_OBC(2014.10.9)\CODE\svm\Data\';

% count of the graph in the same group
NumImagePC = 10 ;
ClassNum=4;

for kind=1:ClassNum,
    
    num = 1;
    Array = cell(NumImagePC, 1) ; % Size is (Num of images peer class *1 *200)
    for i=1:NumImagePC
        
        % read every graph in a order of number in a specific range
        FileName = sprintf('%d.png', kind*100+i-1) ;
        FullPath = strcat(FilePath, FileName) ;
        I = imread(FullPath); % 每类图像为300*200大小
        
        % 提取图像特征
        FR = getFeature(I) ; % FR：SubImageNum*100
        
        % save the feature data in the array.
        Array{i} = FR;
        
        % Cohonen网络聚类算法
        % 对每一幅图像的所划分的块的直方图的特征数据(SubImgeNum*100)进行聚类。每一幅图像聚200类
        ImageClaster =  sofm(FR) ; 
      
        % save the feature data clustered once more in the FRG
        ImageClaster = ImageClaster' ;
        [cout,~] = size(ImageClaster) ;
        FRG(num:num+cout-1, :) = ImageClaster;
        
        num = num + cout ;
    end
    
    % cluster again from all the graph in the same group
    % 每一类图像的每一幅图像的聚类结果（200*ImagePeerClass）再次聚类，聚200个聚类中心
    wvctors = sofm(FRG) ;
 
    % NEST
    svmdata = zeros(NumImagePC,200);
    for i=1:NumImagePC
        temp = Array{i};
        [c,~] = size(temp); % c = 200 ?
        P=zeros(200,1);
        for j=1:200
            vdist = dist(temp, wvctors(:, j)) ;
            add=vdist<40;
            vdist=vdist.*0;
            vdist(add)=1;
            P(j) = sum(vdist) ;
        end
        
        svmdata(i, :) = P;
    end
    
    svmdata = svmdata/c;
end

