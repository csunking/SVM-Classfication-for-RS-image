
% 本函数的目的是为每一个类裁剪子图像
close all; clc;clear;
BolockSize=5;
halfWidth= (BolockSize-1)/2;
ClassNum=4;
EveryClassNum=10;

IMG=imread('zmd.png');
[M,N,P]=size(IMG);
figure,imshow(IMG);
for class_id=1:ClassNum,
    hold on;
    text(0,M+30,sprintf('Class:%2d/%2d--%3d-->%3d\n',ClassNum,class_id,EveryClassNum,0),'BackgroundColor',[.6 .9 .6]);
    for i=1:EveryClassNum,
        [c,r]=ginput(1);
        messages=sprintf('Class:%2d/%2d--%3d-->%3d\n',ClassNum,class_id,EveryClassNum,i);
        fprintf(1,messages);
        c=round(c);r=round(r);
        if c>N-halfWidth,c=N-halfWidth;end
        if c<halfWidth+1,c=halfWidth+1;end
        if r>M-halfWidth,r=M-halfWidth;end
        if r<halfWidth+1,r=halfWidth+1;end
        plot(c,r,'r*','MarkerSize',5);
        text(0,M+30,messages,'BackgroundColor',[.6 .9 .6]);%'HorizontalAlignment','center'
        temp=IMG(r-halfWidth:r+halfWidth,c-halfWidth:c+halfWidth,:);
        FileName = sprintf('%d.png', class_id*100+i-1);
        cd Data\
        imwrite(temp,FileName);
        cd ..\
    end
    hold off;
end
close all;
