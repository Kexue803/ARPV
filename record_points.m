close all;
clear; clc;
% n=input( 'please input number of points n=');  %�����˹�����Ҫѡ������
n=10; %д��
% n=0;
flag=imread('./image/3.jpg');
imshow(flag);

% loc_points=kuangxuan(flag);   %ͨ����ѡ���߷�Χ�� ѡȡ���ɵ�

loc_points = loc_points(n);  %%�˹�ѡȡ���ܵ㣬���ѡȡ
% loc_points(1,:)
figure;
subplot(2,2,1);
imshow(flag);

flag_hsv = rgb2hsv(flag); % ��ͼ���rgbɫ�ʿռ�ת����hsvɫ�ʿռ�  
subplot(2,2,2);
imshow(flag_hsv);
%����ѡ���Ŀ��ɵ㣬�ж��������ص���ֵ
[r,c] = size(loc_points);    % ��ȡ��r����c
points=zeros(r,3);

for i = 1:r        % ����forѭ��Ƕ��
    points(i,:,:) = flag_hsv(round(loc_points(i,2)),round(loc_points(i,1)),:);     % ��ȡ����ÿ��λ�����ݣ����к���
end
