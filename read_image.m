close all;
clear; clc;
pt = 'C:\Users\Lenovo\Desktop\������\��ͼƬ\';
ext = '*.JPG';
dis = dir([pt ext]);
nms = {dis.name};
count=0;
n = 6; %��ҪԤ��ѡȡ�ĵ���
for k = 1:1:length(nms)
    figure;
    nm = [pt nms{k}];
    a = strsplit(nms{k}, '.');
    str = a(1);
    flag = imread(nm); % ��ͼ
    % ��ͼ��image������ز���
%     imshow(image);
    count=count+1;%�ļ�����Ŀ
    process(n, flag, str{1});
   close all;
end
