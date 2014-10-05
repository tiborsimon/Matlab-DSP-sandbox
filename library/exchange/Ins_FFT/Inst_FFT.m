function varargout = Inst_FFT(varargin)
%
%[Function Description] 
%This function creates a user interface through
%which the user can view the FFT of any part of a given signal.
%
%[How to use]
%Execute the function. In th UI enter the the sampling frequency and the
%window length in number of samples. And load the signal. Click at any
%point on the signal. The program will create a window of the given length 
%at that point and the FFT is displayed
%
%[Author]
%Shreyes


% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Inst_FFT_OpeningFcn, ...
    'gui_OutputFcn',  @Inst_FFT_OutputFcn, ...
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


% --- Executes just before Inst_FFT is made visible.
function Inst_FFT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Inst_FFT (see VARARGIN)

% Choose default command line output for Inst_FFT
%handles.output = hObject;

handles.output = figure;
title('FFT Window');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Inst_FFT wait for user response (see UIRESUME)
% uiwait(handles.main_window);


% --- Outputs from this function are returned to the command line.
function varargout = Inst_FFT_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function Fs_Holder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fs_Holder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function Win_Holder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Win_Holder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_Button.
function Load_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA


set(handles.Fs_Holder,'Enable','off');
set(handles.Win_Holder,'Enable','off');

source_sel = get(handles.src_sel,'SelectedObject');
source = get(source_sel,'String');
switch upper(source)
    case 'WORKSPACE'
        
        work_space_var = evalin('base','whos');        
        var_names = {};       
        for i = 1:length(work_space_var)
            temp = evalin('base',work_space_var(i).name);
            [m n] = size(temp);
            if m == 1 && n > 1
                var_names{end + 1} = work_space_var(i).name;
            end
        end
        
        if isempty(var_names)
            msgbox('No single dimension array found!');
            set(handles.Fs_Holder,'Enable','on');
            set(handles.Win_Holder,'Enable','on');
            return;
        end
        
        [var_select, ok] = listdlg('ListString', var_names,'SelectionMode','single','Name','Please select one variable','ListSize',[300 300]);
        if ok
            data = evalin('base', var_names{var_select});
            fs = 1/str2double(get(handles.Fs_Holder,'String'));
            if isnan(fs)
                msgbox('Please unload the signal and enter a value for sampling frequency');
                return;
            end
            time_data = fs:fs:length(data)*fs;
            plot(time_data,data,'parent',handles.Source);
        else
            set(handles.Fs_Holder,'Enable','on');
            set(handles.Win_Holder,'Enable','on');
            return;
        end
               
    case 'FILE'
        [file, path] = uigetfile('*.mat','Select a Matlab Data file5');
        
        if file == 0
            set(handles.Fs_Holder,'Enable','on');
            set(handles.Win_Holder,'Enable','on');
            return;
        end
        
        file_data = load([path file]);
        file_var_names = fieldnames(file_data);
        
        var_names = {};
        for i = 1:length(file_var_names)
            temp = file_data.(file_var_names{i});
            [m n] = size(temp);
            if m == 1 && n > 1
                var_names{end + 1} = file_var_names{i};
            end
        end
        
        if isempty(var_names)
            msgbox('No single dimension array found!');
            set(handles.Fs_Holder,'Enable','on');
            set(handles.Win_Holder,'Enable','on');
            return;
        end
        
        [var_select, ok] = listdlg('ListString', var_names,'SelectionMode','single','Name','Please select one variable','ListSize',[300 300]);
        if ok
            data =  file_data.(var_names{var_select});
            fs = 1/str2double(get(handles.Fs_Holder,'String'));
            if isnan(fs)
                msgbox('Please unload the signal and enter a value for sampling frequency');
                return;
            end
            time_data = fs:fs:length(data)*fs;
            plot(time_data,data,'parent',handles.Source);
        else
            set(handles.Fs_Holder,'Enable','on');
            set(handles.Win_Holder,'Enable','on');
            return;
        end
        
end



% --- Executes on button press in Unload_Button.
function Unload_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Unload_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Fs_Holder,'Enable','on');
set(handles.Win_Holder,'Enable','on');
cla(handles.Source);



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function main_window_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to main_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pt = get(handles.Source,'CurrentPoint');
l_h = get(handles.Source,'children');
if isempty(l_h)
    return;
end
xdata = get(l_h,'Xdata');
ydata = get(l_h,'Ydata');
datalen = length(ydata);

[t, idx] = min(abs(xdata - pt(1,1)));

winlen = round(str2double(get(handles.Win_Holder, 'String')));
if isnan(winlen)
    msgbox('Please unload the signal and enter a value for window length');
    return;
end

Fs = str2double(get(handles.Fs_Holder, 'String'));
if isnan(Fs)
    msgbox('Please unload the signal and enter a value for sampling frequency');
    return;
end

strt_pt = idx - winlen;
end_pt = idx + winlen;

if strt_pt <= 0
    strt_pt = 1;
end

if end_pt > datalen
    end_pt = datalen;
end

fft_source = ydata(strt_pt : end_pt);
fft_source = fft_source.*hamming(length(fft_source))';

L = length(fft_source);
N = 2^nextpow2(L);
fft_data = fft(fft_source,N)/L;
f = Fs/2*linspace(0,1,N/2+1);

out_axes = get(handles.output,'children');
plot(f,2*abs(fft_data(1:N/2+1)),'Parent',out_axes);

text = ['FFT at ' num2str(pt(1,1))];
xlabel(out_axes,text);
