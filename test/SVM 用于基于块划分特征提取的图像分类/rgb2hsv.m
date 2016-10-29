%��R��������RGBģ�ͱ任��HSV
%R Ϊ3ά����
function Hsv = rgb2hsv(R)

%�� uint8��������ת����double��
R = im2double(R);

[h, w, c] = size(R);

for i = 1 : h
    for j = 1 : w
        r = R(i, j, 1);       %red ����
        g = R(i, j, 2);       %green ����  
        b = R(i, j, 3);       %blue ����   
     
        maxc = max(R(i, j, :));
        minc = min(R(i, j, :));
        if (maxc == minc)
            maxc = minc + 1;
        end
        r1 = (maxc - r)/(maxc - minc);
        g1 = (maxc - g)/(maxc - minc);
        b1 = (maxc - b)/(maxc - minc);
        
        v = maxc / 255;
        s = (maxc - minc)/maxc;
        
        if (r == maxc && g == minc)
            h = (5 + b1)/6;
        elseif(r == maxc && g ~= minc)
            h = (1 - g1)/6;
        elseif(g == maxc && b == minc)
            h = (1 + r1)/6;
        elseif(g == maxc && b ~= minc)
            h = (3 - b1)/6;
        elseif(b == maxc && r == minc)
            h = (3 + g1)/6;
        else
            h = (5 - r1)/6;
        end
        
        %�任���hsv����
        %R-->H ,G-->S,  B-->V
        Hsv(i, j, 1) = h;
        Hsv(i, j, 2) = s;
        Hsv(i, j, 3) = v;
    end
end