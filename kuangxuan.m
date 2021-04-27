function loc_points = kuangxuan(image)
loc_points=zeros();
imshow(image);
h = imrect;
pos = wait(h);
count = 1;
for i=round(pos(1)):1:round(pos(1)+pos(3))
    for j=round(pos(2)):1:round(pos(2)+pos(4))
        loc_points(count,1) = i;
        loc_points(count,2) = j;
        count = count+1;
    end
end
