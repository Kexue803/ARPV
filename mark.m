function mark(flag,flag_hsv,flag_new_hsv,pixel,str)

% [row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>0.1...
% & flag_hsv(:,:,1)<= 0.999 & flag_hsv(:,:,2)<0.4 & flag_hsv(:,:,3)<0.59));% �ҳ�ͼ������ɫ������
% [row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>0.1...
% & flag_hsv(:,:,1)<= pixel(:,:,1)+0.015 & flag_hsv(:,:,2)<pixel(:,:,2)+0.015 & flag_hsv(:,:,3)<pixel(:,:,3)+0.015));% �ҳ�ͼ������ɫ������
[row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>=pixel(:,:,1)-0.055...
& flag_hsv(:,:,1)<= pixel(:,:,1)+0.055 & flag_hsv(:,:,2)<pixel(:,:,2)+0.055 & flag_hsv(:,:,3)<pixel(:,:,3)+0.055));


for i = 1 : length(row)
    flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
end
flag_black = hsv2rgb(flag_new_hsv);

gray_black = rgb2gray(flag_black);
T = graythresh(gray_black); %�õ�һ����ֵ
bw_black = im2bw(gray_black, T); %ת��Ϊ��ֵͼ��
%bw_black=edge(bw_black, 'sobel');
subplot(2,2,3);
imshow(bw_black);
str = [str '.jpg'];
str1 = ['bw_black\' str];
imwrite(bw_black, str1);
dbw_black=imcomplement(bw_black);%��ֵͼ��ȡ��

img_reg = regionprops(dbw_black,  'basic');
areas = [img_reg.Area];%�����������������
rects = cat(1,  img_reg.BoundingBox);%�����ֵ���С����

% subplot(2,2,4);
figure;
imshow(flag);
h=gca;
for i = 1:size(rects, 1)     %��ȡ����
    rectangle('position', rects(i, :), 'EdgeColor', 'b');
%     rectangle('position', rects(i, :), 'Curvature', [1 1], 'b');
end
text(0,0, '������������','color','blue','FontSize',10);
str2 = ['bw_rects\' str];
saveas(h,str2);
% imwrite(flag, str2);