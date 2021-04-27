close all;
clear; clc;
% n=input( 'please input number of points n=');  %可以人工输入要选几个点
n=10; %写死
% n=0;
flag=imread('./image/3.jpg');
imshow(flag);

% loc_points=kuangxuan(flag);   %通过框选瘀斑范围， 选取可疑点

loc_points = loc_points(n);  %%人工选取可能点，逐点选取
% loc_points(1,:)
figure;
subplot(2,2,1);
imshow(flag);

flag_hsv = rgb2hsv(flag); % 将图像的rgb色彩空间转化至hsv色彩空间  
subplot(2,2,2);
imshow(flag_hsv);
%根据选定的可疑点，判定瘀斑像素的阈值
[r,c] = size(loc_points);    % 读取行r、列c
points=zeros(r,3);

for i = 1:r        % 建立for循环嵌套
    points(i,:,:) = flag_hsv(round(loc_points(i,2)),round(loc_points(i,1)),:);     % 读取矩阵每个位置数据，先行后列
end
