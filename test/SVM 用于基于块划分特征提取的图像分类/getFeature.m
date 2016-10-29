function FR = getFeature(I)
% I为图像的像素值
% FR为SubImageNum*100维的特征向量矩阵
% Modified by WENG 2014.12.25 2008
% hurricanblue@126.com

%采用wh * ww 窗口划分图像
I = im2double(I);
[M, N, ~] = size(I);

block_RW =  5 ;
block_CW =  5 ;

SubImgNum_R = floor(M/block_RW) ;
SubImgNum_C = floor(N/block_CW) ;

R_Start = (0:SubImgNum_R-1)*block_RW + 1;
R_End   = (1:SubImgNum_R)*block_RW;
C_Start = (0:SubImgNum_C-1)*block_CW + 1;
C_End   = (1:SubImgNum_C)*block_CW;

%figure;
for i = 1 : SubImgNum_R
    for j = 1 : SubImgNum_C
        
        SubImg = I(R_Start(i):R_End(i), C_Start(j):C_End(j), :);
        
        %将像素的RGB模式转换为HSV.
        H = rgb2hsv(SubImg) ;
        
        %将HSV像素量化为100级
        Q =  ceil(H.*10);
        MPixel = Q(:, :, 1).*Q(:, :, 2) ;
        
        %将Q矩阵线性化
        Lv=reshape(MPixel',1,r*c);

        %量化值转换为直方图
        Histogram = zeros(1,100);
        for k = 1 : r*c
            Histogram(1, Lv(1, k)) = Histogram(1, Lv(1, k)) + 1 ;
        end
        
        FR((i-1)*SubImgNum_C+j , :) = Histogram ; %#ok<AGROW>
        %subplot(crank, ccolm, (i-1)*ccolm+j);
        %imshow(temp);
        %pause(0.1);
    end
end
