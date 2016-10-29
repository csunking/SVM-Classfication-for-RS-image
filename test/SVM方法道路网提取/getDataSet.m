function DataSet = getDataSet(IMG,classNames,BolockSize,EveryClassSampleNum )
% 该图像是获取SVM初始道路分割的数据集程序
% Designed by WENG ( HHU,hurricanblue@126.com.), 2015-1-2-2144
% Copyright (c) 2015. All rights reserved.
clc;
if nargin<1,
    classNames={'road';'buildings';'other'};    % 类别名字
    BolockSize=5;                   % 块大小
    EveryClassSampleNum=10;         % 每类采集的点数
    IMG=imread('0.png');          % 图像数据
end

halfWidth= (BolockSize-1)/2;    % 块半宽
ClassNum=size(classNames,1);
DataSet=cell(ClassNum,EveryClassSampleNum);
[M,N,P]=size(IMG);
if P>3,IMG_toshow=IMG(:,:,[22,11,9]);else IMG_toshow=IMG;end



figure,imshow(IMG_toshow);
markColorVec=['y','m','c','r','g','b','w','k'];
markShapeVec=['s','o','*','x','d','v','>','<'];
markColorVec_count=1;
for class_id=1:ClassNum,
    hold on;
    text(0,M+20,sprintf('Class:%2d/%2d--%3d-->%3d\n',ClassNum,class_id,EveryClassSampleNum,0),'BackgroundColor',[.6 .9 .6]);
    text(0,M+70,sprintf('Class Type: %s',classNames{class_id}),'BackgroundColor',[.8 .5 .6]);
    for subimg_i=1:EveryClassSampleNum,
        [c,r]=ginput(1);
        messages=sprintf('Class:%2d/%2d--%3d-->%3d\n',ClassNum,class_id,EveryClassSampleNum,subimg_i);
        fprintf(1,messages);
        c=round(c);r=round(r);
        if c>N-halfWidth,c=N-halfWidth;end
        if c<halfWidth+1,c=halfWidth+1;end
        if r>M-halfWidth,r=M-halfWidth;end
        if r<halfWidth+1,r=halfWidth+1;end
        if markColorVec_count>length(markColorVec),markColorVec_count=1;end
        eval(['plot(c,r,''',markColorVec(class_id),markShapeVec(class_id),...
            ''',''MarkerSize'',5,''MarkerFaceColor'',[',sprintf('%f %f %f',...
            (255.0-IMG(r,c,1))/255.0,(255.0-IMG(r,c,2))/255.0,(255.0-IMG(r,c,3))/255.0),'],''LineWidth'',2);']);
        text(0,M+20,messages,'BackgroundColor',[.6 .9 .6]);%'HorizontalAlignment','center'
        temp=IMG(r-halfWidth:r+halfWidth,c-halfWidth:c+halfWidth,:);
        DataSet{class_id,subimg_i}=temp;
    end
    
    markColorVec_count=markColorVec_count+1;
end
hold off;
close;

end

