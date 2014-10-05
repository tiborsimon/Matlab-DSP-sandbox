function varargout = FrequencyPlot(varargin)
 % - use 'Update data' button to load workspace variables to listbox
 % - workspace variables are type double column vectors 
 % - add data to graph by right mouse click on listbox data 
 %   (multiple selections possible)
 % - clicking on graph displays name of selected data
 % - remove data from graph by right mouse click on selected plot
 % - use the 'rescale to' edit to set the entered value to 0 dB
 
 % NOTE: make sure data's sample rate is always 44.1 kHz

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FrequencyPlot_OpeningFcn, ...
                   'gui_OutputFcn',  @FrequencyPlot_OutputFcn, ...
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

%--------------------------------------------------------------------------
% --- Executes just before FrequencyPlot is made visible.
function FrequencyPlot_OpeningFcn(hObject, eventdata, handles, varargin)
set(gcf,'Name','Frequency Response');
axes(handles.mono_axes);
set(handles.mono_axes,...
    'FontWeight','bold',...
    'XGrid','on',...
    'XMinorGrid','on',...
    'XTick',[16,22,32,45,63,89,126,178,251,355,501,708,1000,1413,1995,2818,3981,5623,7943,11220,15849],...
    'XTickLabel',{'16','22','32','45','63','90','125','180','250','350','500','700','1k','1.4k','2k','2.8','4k','5.6k','8k','11.2k','16k'},...
    'XScale','log','YGrid','on')
xlim([22 16000]);
box('on');
hold('all'); 
% Create xlabel
xlabel('frequency / Hz','FontWeight','bold');
% Create ylabel
ylabel('amplitude / dB','FontWeight','bold');

% Choose default command line output for FrequencyPlot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% design options
axes(handles.mono_axes) 

% read workspace variables on start
set(handles.fullzoom,'Value',0);

%--------------------------------------------------------------------------
% --- Outputs from this function are returned to the command line.
function varargout = FrequencyPlot_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------------------------------------------------------------------------
function update_listbox(handles)
data= evalin('base','who');
if length(data) > 0    
    vars = evalin('base','whos');
    vars=struct2cell(vars);
    N=vars(2,:);
    vars=vars(4,:);
    L=length(vars);
    for i=1:L
        cl=cell2mat(vars(i));
        Li=cell2mat(N(i));
        if strcmp(cl,'double')==1  && Li(1)>1
            TimeData(i)=1;
        else
            TimeData(i)=0;
        end
    end
    TimeData=find(TimeData==1)';
    TimeData=data(TimeData);
else
    TimeData=[];
end
if length(TimeData)>1
set(handles.dataselection,'String',TimeData);
end

%--------------------------------------------------------------------------
function dataselection_Callback(hObject, eventdata, handles)
name = get(handles.dataselection,'String');
indx = get(handles.dataselection,'Value');
setappdata(handles.add,'name',name);
setappdata(handles.add,'indx',indx );

%--------------------------------------------------------------------------
function dataselection_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function end_edit_Callback(hObject, eventdata, handles)
if strcmp(get(handles.end_edit,'String'),'end')==1
    fend=16000;
else  
    fend=str2double(get(handles.end_edit,'String'));
end
fstart=str2double(get(handles.start_edit,'String'));
set(gca,'Xlim',[fstart fend]);

%--------------------------------------------------------------------------
function end_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------------
function start_edit_Callback(hObject, eventdata, handles)
if strcmp(get(handles.start_edit,'String'),'start')==1
    fstart=32;
else
    fstart=str2double(get(handles.start_edit,'String'));
end
fend=str2double(get(handles.end_edit,'String'));
set(gca,'Xlim',[fstart fend]);

% --------------------------------------------------------------------
function start_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------------
function yend_edit_Callback(hObject, eventdata, handles)
yend=str2double(get(handles.yend_edit,'String'));
ystart=str2double(get(handles.ystart_edit,'String'));
set(gca,'Ylim',[ystart yend]);

%--------------------------------------------------------------------------
function yend_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------------
function ystart_edit_Callback(hObject, eventdata, handles)
yend=str2double(get(handles.yend_edit,'String'));
ystart=str2double(get(handles.ystart_edit,'String'));
set(gca,'Ylim',[ystart yend]);

%--------------------------------------------------------------------------
function ystart_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------------
function fullzoom_Callback(hObject, eventdata, handles)
set(handles.pan,'Value',0);
zoom on
if get(hObject,'Value')==0
    zoom off
end
ch_button_state=get(handles.ch_togglebutton,'Value');
if ch_button_state==get(handles.ch_togglebutton,'Max')
    linkaxes([handles.left_axes handles.right_axes]);
else
    linkaxes([handles.left_axes handles.right_axes],'off');
end
x_lim=get(gca,'XLim');
y_lim=get(gca,'YLim');
set(handles.start_edit,'String',x_lim(:,1));
set(handles.end_edit,'String',x_lim(:,2));
set(handles.ystart_edit,'String',y_lim(:,1));
set(handles.yend_edit,'String',y_lim(:,2));

% --------------------------------------------------------------------
function zoomx_Callback(hObject, eventdata, handles)
zoom xon
set(handles.pan,'Value',0);
if get(hObject,'Value')==0
    zoom off
end
x_lim=get(gca,'XLim');
y_lim=get(gca,'YLim');
set(handles.start_edit,'String',x_lim(:,1));
set(handles.end_edit,'String',x_lim(:,2));
set(handles.ystart_edit,'String',y_lim(:,1));
set(handles.yend_edit,'String',y_lim(:,2));

% --------------------------------------------------------------------
function zoomy_Callback(hObject, eventdata, handles)
set(handles.pan,'Value',0);
zoom yon
if get(hObject,'Value')==0
    zoom off
end
x_lim=get(gca,'XLim');
y_lim=get(gca,'YLim');
set(handles.start_edit,'String',x_lim(:,1));
set(handles.end_edit,'String',x_lim(:,2));
set(handles.ystart_edit,'String',y_lim(:,1));
set(handles.yend_edit,'String',y_lim(:,2));

% --------------------------------------------------------------------
function pan_Callback(hObject, eventdata, handles)
set(handles.panzoomoff,'Value',1);
pan on
if get(hObject,'Value')==0
    pan off
end
x_lim=get(gca,'XLim');
y_lim=get(gca,'YLim');
set(handles.start_edit,'String',x_lim(:,1));
set(handles.end_edit,'String',x_lim(:,2));
set(handles.ystart_edit,'String',y_lim(:,1));
set(handles.yend_edit,'String',y_lim(:,2));

%--------------------------------------------------------------------------
function xachses_pushbutton_Callback(hObject, eventdata, handles)
x_lim=get(gca,'XLim');
set(handles.start_edit,'String',x_lim(:,1));
set(handles.end_edit,'String',x_lim(:,2));

%--------------------------------------------------------------------------
function yachses_pushbutton_Callback(hObject, eventdata, handles)
y_lim=get(gca,'YLim');
set(handles.ystart_edit,'String',y_lim(:,1));
set(handles.yend_edit,'String',y_lim(:,2));

% --------------------------------------------------------------------
function panzoomoff_Callback(hObject, eventdata, handles)
zoom off
pan off
x_lim=get(gca,'XLim');
y_lim=get(gca,'YLim');
set(handles.start_edit,'String',x_lim(:,1));
set(handles.end_edit,'String',x_lim(:,2));
set(handles.ystart_edit,'String',y_lim(:,1));
set(handles.yend_edit,'String',y_lim(:,2));
set(handles.fullzoom,'Value',0);
set(handles.pan,'Value',0);

% --------------------------------------------------------------------
function add_Callback(hObject, eventdata, handles)
if isempty(findobj('Type','line'))==1
    set(handles.cal,'String',0);
end
name=getappdata(handles.add,'name');
indx=getappdata(handles.add,'indx');
Noct=str2double(get(handles.Noct,'String'));
Nfft=str2double(get(handles.Nfft,'String'));
cal=str2double(get(handles.cal,'String'));
for i=1:length(indx)
    data=cell2mat(name(indx(i)));
    data=evalin('base',data);
    [FR,freq]=averfft(data,Noct,Nfft);
    plot(freq,FR-cal,'LineWidth',2,'Tag',cell2mat(name(indx(i))));
end

% --------------------------------------------------------------------
function update_Callback(hObject, eventdata, handles)
update_listbox(handles);

% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
[Name,Path]   = uigetfile('*.wav');
assignin('base','a',Name);
if ~isequal(Name, 0)
    [wavefile,fs]=wavread([Path Name]);
    if fs==44100
        Name=Name(1:find(Name=='.',1,'first')-1);
        if  isvarname(Name)==0
            Name=genvarname(Name);
        end
        assignin('base',Name,wavefile);
        update_listbox(handles);
    else
        errordlg('Only sample rates of 44.1 kHz supported');
    end
end

% --------------------------------------------------------------------
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
if strcmp(get(gco,'Type'),'line')==1
    cp = get(gca,'CurrentPoint');
    x = cp(1,1);       
    y = cp(1,2);
    Name=get(gco,'Tag');
    text(x+0.1,y+0.1,Name,'BackgroundColor','w','FontWeight','bold','FontSize',10,'Tag','text','Color',get(gco,'Color'));
    cmenu = uicontextmenu;       
    set(gco,'UIContextMenu',cmenu);    
    uimenu(cmenu, 'Label', 'Delete','Callback','delete(gco)');
    uimenu(cmenu, 'Label', 'Delete all','Callback','cla');
end

% --------------------------------------------------------------------
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
delete(findobj(gcf,'Tag','text'));

% --------------------------------------------------------------------
function cal_Callback(hObject, eventdata, handles)
cal=str2double(get(handles.cal,'String'));
lines=findobj(gca,'Type','line');
for i=1:length(lines)
    set(lines(i),'Ydata',get(lines(i),'YData')-cal);
end

% --------------------------------------------------------------------
function cal_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
set(gca,'Xlim',[20 20000]);

% --------------------------------------------------------------------
function data_selection_cm_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Noct_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Noct_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function Nfft_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Nfft_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


