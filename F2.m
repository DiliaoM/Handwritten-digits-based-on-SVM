function varargout = F2(varargin)
% F2 MATLAB code for F2.fig
%      F2, by itself, creates a new F2 or raises the existing
%      singleton*.
%
%      H = F2 returns the handle to a new F2 or the handle to
%      the existing singleton*.
%
%      F2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F2.M with the given input arguments.
%
%      F2('Property','Value',...) creates a new F2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F2

% Last Modified by GUIDE v2.5 24-Dec-2017 20:08:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F2_OpeningFcn, ...
                   'gui_OutputFcn',  @F2_OutputFcn, ...
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


% --- Executes during object creation, after setting all properties.
% function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% set(handles.axes1,'XLim',[0 1],'YLim',[0 1]);


% --- Executes just before F2 is made visible.
function F2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F2 (see VARARGIN)

% Choose default command line output for F2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.axes1,'visible','off');
set(handles.axes1,'XLim',[0 1],'YLim',[0 1]) 

% UIWAIT makes F2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F2_OutputFcn(hObject, eventdata, handles) 
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
axes(handles.axes1);
cla;
set(handles.axes1,'XLim',[0 1],'YLim',[0 1])
% set(handles.axes1,'xlim',[0,1])
% axes('Position',[0 1 0 1],'tag','axes1');


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable;
global x;
global y;
draw_enable = 1;
if draw_enable == 1
    p = get(gca,'currentpoint');       %鼠标按下，获取当前坐标
    x(1) = p(1);
    y(1) = p(3);
end


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable;
global x;
global y;
global h1;
if draw_enable 
    p = get(gca,'currentpoint');
    x(2) = p(1);
    y(2) = p(3);
    h1 = line(x,y,'EraseMode','xor','LineWidth',30,'color','w');
    x(1) = x(2);
    y(1) = y(2);         % 鼠标移动时，随时更新折线的数据
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable;
draw_enable = 0;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% save as jpg file. 
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';'*.bmp','Bitmap(*.bmp)';'*.gif','GIF(*.gif)';'*.*',  'All Files (*.*)'},...
                                 'Save Picture','Untitled');
% [FileName,PathName] = uiputfile('*.bmp','Bitmap(*.bmp)','Save Picture','Untitled');
if FileName==0
    return;
else
    h=getframe(handles.axes1);
    s = digits_predict(h.cdata);
    set(handles.edit2,'string',num2str(s)); % write into the text
    % set(handles.edit2,'string',digits_predict(handles.cdata,tr));
    imwrite(h.cdata,[PathName,FileName]);
end



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
