function loc_point = loc_points(n)
loc_point=zeros(n,2);
%[x,y]=getpts;
for i=1:1:6
    hold on;  
    [x, y]=ginput(1);
    hold on;
    plot(x,y,'r.')%将点在其中标记出来
    loc_point(i,1) = x;
    loc_point(i,2) = y;
    str=['  X:' num2str(x') ', Y:' num2str(y')];
    text(x,y,cellstr(str))
end
