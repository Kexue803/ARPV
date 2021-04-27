function varargout = ceshi(varargin)
% CESHI MATLAB code for ceshi.fig
%      CESHI, by itself, creates a new CESHI or raises the existing
%      singleton*.
%
%      H = CESHI returns the handle to a new CESHI or the handle to
%      the existing singleton*.
%
%      CESHI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CESHI.M with the given input arguments.
%
%      CESHI('Property','Value',...) creates a new CESHI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ceshi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ceshi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ceshi

% Last Modified by GUIDE v2.5 09-Apr-2021 13:19:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ceshi_OpeningFcn, ...
                   'gui_OutputFcn',  @ceshi_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
global bw_black
global str
% --- Executes just before ceshi is made visible.
function ceshi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ceshi (see VARARGIN)
% Choose default command line output for ceshi
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes ceshi wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = ceshi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I 
global str
[filename,pathname]=uigetfile({'*.jpg';' *.jpeg'; '*.bmp'},'选择图片');
if isequal(filename,0)
    disp('user seleted canceled');
else
    str=[pathname filename];
    I=imread(str);
    axes(handles.axes1);
    imshow(I)
    set(handles.text2,'string', str);
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw_black
global str
global n
n=6;
% if isempty(str)
%     set(handles.text3,'string', '请先选取预检测的舌像图片！！！');
% end
flag = imread(str);
figure;
imshow(flag);
loc_point=zeros(n,2);
%[x,y]=getpts;
for i=1:1:n
    hold on;  
    [x, y]=ginput(1);
    hold on;
    plot(x,y,'r.')%将点在其中标记出来
    loc_point(i,1) = x;
    loc_point(i,2) = y;
    str=['  X:' num2str(x') ', Y:' num2str(y')];
    text(x,y,cellstr(str))
end
h1 = figure(1);
imshow(flag);
flag_hsv = rgb2hsv(flag); % 将图像的rgb色彩空间转化至hsv色彩空间  
h2 = figure(2);
imshow(flag_hsv);
%根据选定的可疑点，判定瘀斑像素的阈值
[r,c] = size(loc_point);    % 读取行r、列c
pixel=zeros(1,1,3);
for i = 1:r        % 建立for循环嵌套
    pixel = pixel + flag_hsv(round(loc_point(i,2)),round(loc_point(i,1)),:);     % 读取矩阵每个位置数据，先行后列
end
pixel = pixel/r;
close(h1);
close(h2);
% 判定预选值是否符合常见瘀斑点的范围
if pixel(1,1,1)>0.5 && pixel(1,1,1)<0.995 && pixel(1,1,2)<0.44 && pixel(1,1,3)<0.61
     fprintf('数据预选符合要求！！！');
     set(handles.text3,'string', '数据预选符合要求！！！');
else 
    fprintf('预选数据存在不适当点，结果可能存在误差！！！');
    set(handles.text3,'string', '预选数据存在不适当点，结果可能存在误差！！！')
end  
flag_new = 255*ones(size(flag));% 创建一个白色图像，将特定颜色提取到此处
flag_new_hsv = rgb2hsv(flag_new);% 将该图像转至hsv色彩空间
[row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>=pixel(:,:,1)-0.055...
& flag_hsv(:,:,1)<= pixel(:,:,1)+0.055 & flag_hsv(:,:,2)<pixel(:,:,2)+0.055 & flag_hsv(:,:,3)<pixel(:,:,3)+0.055));
for i = 1 : length(row)
    flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
end
flag_black = hsv2rgb(flag_new_hsv);
gray_black = rgb2gray(flag_black);
T = graythresh(gray_black); %得到一个阈值
bw_black = im2bw(gray_black, T); %转化为二值图像
%bw_black=edge(bw_black, 'sobel');
axes(handles.axes2);
imshow(bw_black);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global str
% global bw_black
% str = [str '.jpg'];
% str1 = ['bw_black\' str];
% imwrite(bw_black, str1);
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';...
                                 '*.bmp','Bitmap(*.bmp)';...
                                 '*.gif','GIF(*.gif)';...
                                 '*.*',  'All Files (*.*)'},...
                                 'Save Picture','Untitled');
if FileName==0
    return;
else
    h=getframe(handles.axes2);
    imwrite(h.cdata,[PathName,FileName]);
end;
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% button5=questdlg('你确定退出吗?','退出程序','确定','取消','确定');
% if strcmp(button5,'Yes')
%     set(handles.text2,'String','');%%最后的2个单引号，中间的内容是空哦，也就是清空
% end;
% 重置清空图片 
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
% cla(handles.axes3,'reset');
% cla(handles.axes4,'reset');
% cla(handles.axes5,'reset');
% set(handles.axes1,'XTick',[],'YTick',[],'XTicklabel',[],'YTicklable',[]);
% set(handles.axes1,'XLim',[xmin xmax],'YLim',[ymin ymax]);
% set(handles.axes2,'XTick',[],'YTick',[],'XTicklabel',[],'YTicklable',[]);
% set(handles.axes2,'XLim',[xmin xmax],'YLim',[ymin ymax]);
% set(handles.axes1,'visible','off');
% box on; %在坐标轴四周加上边框
set(handles.axes1,'xtick',[], 'xColor',[1 1 1]);
set(handles.axes1,'ytick',[],'yColor',[1 1 1])
set(handles.axes2,'xtick',[], 'xColor',[1 1 1]);
set(handles.axes2,'ytick',[],'yColor',[1 1 1])
% 重置清空动态txt的文字 
set(handles.text2,'string','路径')
set(handles.text3,'string','提示')
% set(handles.edit3,'string','')
% set(handles.edit4,'string','')
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% button6=questdlg('你确定退出吗?','退出程序','确定','取消','确定');
% if strcmp(button6,'Yes')
%     close;    
% %     set(handles.text2,'String','');%%最后的2个单引号，中间的内容是空哦，也就是清空
% end;
if isequal(questdlg('Quit or not?','退出','Yes', 'No', 'Yes'), 'Yes')
closereq; % 试试这个函数
end
 % Exit_Callback
