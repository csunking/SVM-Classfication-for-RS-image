%ͼ�����
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
        I = imread(FullPath); % ÿ��ͼ��Ϊ300*200��С
        
        % ��ȡͼ������
        FR = getFeature(I) ; % FR��SubImageNum*100
        
        % save the feature data in the array.
        Array{i} = FR;
        
        % Cohonen��������㷨
        % ��ÿһ��ͼ��������ֵĿ��ֱ��ͼ����������(SubImgeNum*100)���о��ࡣÿһ��ͼ���200��
        ImageClaster =  sofm(FR) ; 
      
        % save the feature data clustered once more in the FRG
        ImageClaster = ImageClaster' ;
        [cout,~] = size(ImageClaster) ;
        FRG(num:num+cout-1, :) = ImageClaster;
        
        num = num + cout ;
    end
    
    % cluster again from all the graph in the same group
    % ÿһ��ͼ���ÿһ��ͼ��ľ�������200*ImagePeerClass���ٴξ��࣬��200����������
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

