function test_SA()


if nargin<1,
    PROJECTNAME='谷歌卫星_151106114517';
    clc;
    imtool close all;
end

if ~exist(sprintf('data\\%s.mat',PROJECTNAME),'file')
    % INFO = imfinfo(sprintf('data\\%s.tif',PROJECTNAME),'tif');                                 %iNFO: resample file name
    IMG=imread(sprintf('data\\%s.tif',PROJECTNAME),'tif');                                     %resample file name
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
    save(sprintf('data\\%s.mat',PROJECTNAME),'IMG_normalize');
else
    load(sprintf('data\\%s.mat',PROJECTNAME));
    [M,N,P]=size(IMG_normalize); %#ok<ASGLU,NODEF>
end
% vec_to_show=[22,11,9];
% imtool(IMG_normalize(:,:,vec_to_show),[]);
imtool(IMG_normalize,[]);


% calculate the edge map
% -------------------------------------------------------------------------
fprintf(1,'---------------------------------------------\nEdge Map is calculating, please wait...\n\n     ');
CalculatingNum=(M-2)*(N-2);
EdgeMap=zeros(M,N);
for j=2:N-1,
    for i=2:M-1,
        TemplateValue=SA(IMG_normalize(i-1,j-1,:),IMG_normalize(i,j,:))+2*SA(IMG_normalize(i-1,j,:),IMG_normalize(i,j,:))+...
            SA(IMG_normalize(i-1,j+1,:),IMG_normalize(i,j,:))+...
            2*SA(IMG_normalize(i,j-1,:),IMG_normalize(i,j,:))+2*SA(IMG_normalize(i,j+1,:),IMG_normalize(i,j,:))+...
            SA(IMG_normalize(i+1,j-1,:),IMG_normalize(i,j,:))+2*SA(IMG_normalize(i+1,j,:),IMG_normalize(i,j,:))+...
            SA(IMG_normalize(i+1,j+1,:),IMG_normalize(i,j,:));
        EdgeMap(i,j)=(TemplateValue)/12;
        fprintf(1,'\n\b\b\b\b\b\b\b\b%6.2f%%',double((j-2)*(M-2)+i-1)/CalculatingNum*100.0);
    end
end

% fine the boundary of the edge map
EdgeMap(1,:)=EdgeMap(2,:);
EdgeMap(end,:)=EdgeMap(end-1,:);
EdgeMap(:,1)=EdgeMap(:,2);
EdgeMap(:,end)=EdgeMap(:,end-1);
EdgeMap(1,1)=EdgeMap(2,2);
EdgeMap(end,1)=EdgeMap(end-1,2);
EdgeMap(1,end)=EdgeMap(2,end-1);
EdgeMap(end,end)=EdgeMap(end-1,end-1);
imtool(EdgeMap,[],'Colormap',jet);
save(sprintf( 'EdgeMap_%s.mat',PROJECTNAME),'EdgeMap');




end




function angle=SA(v1,v2)
% 计算光谱角

v1=v1(:);
v2=v2(:);
multiplays=v1'*v2;
norm_multiplays=norm(v1)*norm(v2);
angle=acosd(multiplays/norm_multiplays);
if angle<0,angle=angle+180;end
end