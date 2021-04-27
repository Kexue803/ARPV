function  process(n, flag, str)

% close all;
% clear; clc;
% n=input( 'please input number of points n=');  %可以人工输入要选几个点
% n=6; %写死
% n=0;
% flag=imread('./image/6.jpg');
imshow(flag);

% loc_points=kuangxuan(flag);   %通过框选瘀斑范围， 选取可疑点
loc_point = loc_points(n);  %%人工选取可能点，逐点选取
% loc_point = loc_points(n);  %%人工选取可能点，逐点选取

% loc_points(1,:)

subplot(2,2,1);
imshow(flag);


flag_hsv = rgb2hsv(flag); % 将图像的rgb色彩空间转化至hsv色彩空间  
subplot(2,2,2);
imshow(flag_hsv);
%根据选定的可疑点，判定瘀斑像素的阈值
[r,c] = size(loc_point);    % 读取行r、列c
pixel=zeros(1,1,3);

for i = 1:r        % 建立for循环嵌套
    pixel = pixel + flag_hsv(round(loc_point(i,2)),round(loc_point(i,1)),:);     % 读取矩阵每个位置数据，先行后列
end
pixel = pixel/r;
% 判定预选值是否符合常见瘀斑点的范围
if pixel(1,1,1)>0.5 && pixel(1,1,1)<0.995 && pixel(1,1,2)<0.44 && pixel(1,1,3)<0.61
     fprintf('数据预选符合要求！！！');
else 
    fprintf('预选数据存在不适当点，结果可能存在误差！！！');
end
    
flag_new = 255*ones(size(flag));% 创建一个白色图像，将特定颜色提取到此处
flag_new_hsv = rgb2hsv(flag_new);% 将该图像转至hsv色彩空间

mark(flag,flag_hsv,flag_new_hsv,pixel,str)