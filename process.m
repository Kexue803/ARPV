function  process(n, flag, str)

% close all;
% clear; clc;
% n=input( 'please input number of points n=');  %�����˹�����Ҫѡ������
% n=6; %д��
% n=0;
% flag=imread('./image/6.jpg');
imshow(flag);

% loc_points=kuangxuan(flag);   %ͨ����ѡ���߷�Χ�� ѡȡ���ɵ�
loc_point = loc_points(n);  %%�˹�ѡȡ���ܵ㣬���ѡȡ
% loc_point = loc_points(n);  %%�˹�ѡȡ���ܵ㣬���ѡȡ

% loc_points(1,:)

subplot(2,2,1);
imshow(flag);


flag_hsv = rgb2hsv(flag); % ��ͼ���rgbɫ�ʿռ�ת����hsvɫ�ʿռ�  
subplot(2,2,2);
imshow(flag_hsv);
%����ѡ���Ŀ��ɵ㣬�ж��������ص���ֵ
[r,c] = size(loc_point);    % ��ȡ��r����c
pixel=zeros(1,1,3);

for i = 1:r        % ����forѭ��Ƕ��
    pixel = pixel + flag_hsv(round(loc_point(i,2)),round(loc_point(i,1)),:);     % ��ȡ����ÿ��λ�����ݣ����к���
end
pixel = pixel/r;
% �ж�Ԥѡֵ�Ƿ���ϳ������ߵ�ķ�Χ
if pixel(1,1,1)>0.5 && pixel(1,1,1)<0.995 && pixel(1,1,2)<0.44 && pixel(1,1,3)<0.61
     fprintf('����Ԥѡ����Ҫ�󣡣���');
else 
    fprintf('Ԥѡ���ݴ��ڲ��ʵ��㣬������ܴ���������');
end
    
flag_new = 255*ones(size(flag));% ����һ����ɫͼ�񣬽��ض���ɫ��ȡ���˴�
flag_new_hsv = rgb2hsv(flag_new);% ����ͼ��ת��hsvɫ�ʿռ�

mark(flag,flag_hsv,flag_new_hsv,pixel,str)