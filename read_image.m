close all;
clear; clc;
pt = 'C:\Users\Lenovo\Desktop\瘀斑舌\舌图片\';
ext = '*.JPG';
dis = dir([pt ext]);
nms = {dis.name};
count=0;
n = 6; %需要预备选取的点数
for k = 1:1:length(nms)
    figure;
    nm = [pt nms{k}];
    a = strsplit(nms{k}, '.');
    str = a(1);
    flag = imread(nm); % 读图
    % 对图像image进行相关操作
%     imshow(image);
    count=count+1;%文件的数目
    process(n, flag, str{1});
   close all;
end
