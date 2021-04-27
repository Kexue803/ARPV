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
[filename,pathname]=uigetfile({'*.jpg';' *.jpeg'; '*.bmp'},'ѡ��ͼƬ');
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
%     set(handles.text3,'string', '����ѡȡԤ��������ͼƬ������');
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
    plot(x,y,'r.')%���������б�ǳ���
    loc_point(i,1) = x;
    loc_point(i,2) = y;
    str=['  X:' num2str(x') ', Y:' num2str(y')];
    text(x,y,cellstr(str))
end
h1 = figure(1);
imshow(flag);
flag_hsv = rgb2hsv(flag); % ��ͼ���rgbɫ�ʿռ�ת����hsvɫ�ʿռ�  
h2 = figure(2);
imshow(flag_hsv);
%����ѡ���Ŀ��ɵ㣬�ж��������ص���ֵ
[r,c] = size(loc_point);    % ��ȡ��r����c
pixel=zeros(1,1,3);
for i = 1:r        % ����forѭ��Ƕ��
    pixel = pixel + flag_hsv(round(loc_point(i,2)),round(loc_point(i,1)),:);     % ��ȡ����ÿ��λ�����ݣ����к���
end
pixel = pixel/r;
close(h1);
close(h2);
% �ж�Ԥѡֵ�Ƿ���ϳ������ߵ�ķ�Χ
if pixel(1,1,1)>0.5 && pixel(1,1,1)<0.995 && pixel(1,1,2)<0.44 && pixel(1,1,3)<0.61
     fprintf('����Ԥѡ����Ҫ�󣡣���');
     set(handles.text3,'string', '����Ԥѡ����Ҫ�󣡣���');
else 
    fprintf('Ԥѡ���ݴ��ڲ��ʵ��㣬������ܴ���������');
    set(handles.text3,'string', 'Ԥѡ���ݴ��ڲ��ʵ��㣬������ܴ���������')
end  
flag_new = 255*ones(size(flag));% ����һ����ɫͼ�񣬽��ض���ɫ��ȡ���˴�
flag_new_hsv = rgb2hsv(flag_new);% ����ͼ��ת��hsvɫ�ʿռ�
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
% button5=questdlg('��ȷ���˳���?','�˳�����','ȷ��','ȡ��','ȷ��');
% if strcmp(button5,'Yes')
%     set(handles.text2,'String','');%%����2�������ţ��м�������ǿ�Ŷ��Ҳ�������
% end;
% �������ͼƬ 
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
% box on; %�����������ܼ��ϱ߿�
set(handles.axes1,'xtick',[], 'xColor',[1 1 1]);
set(handles.axes1,'ytick',[],'yColor',[1 1 1])
set(handles.axes2,'xtick',[], 'xColor',[1 1 1]);
set(handles.axes2,'ytick',[],'yColor',[1 1 1])
% ������ն�̬txt������ 
set(handles.text2,'string','·��')
set(handles.text3,'string','��ʾ')
% set(handles.edit3,'string','')
% set(handles.edit4,'string','')
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% button6=questdlg('��ȷ���˳���?','�˳�����','ȷ��','ȡ��','ȷ��');
% if strcmp(button6,'Yes')
%     close;    
% %     set(handles.text2,'String','');%%����2�������ţ��м�������ǿ�Ŷ��Ҳ�������
% end;
if isequal(questdlg('Quit or not?','�˳�','Yes', 'No', 'Yes'), 'Yes')
closereq; % �����������
end
 % Exit_Callback
