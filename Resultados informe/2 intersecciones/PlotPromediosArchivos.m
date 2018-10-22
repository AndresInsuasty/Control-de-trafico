function varargout = PlotPromediosArchivos(varargin)
% PLOTPROMEDIOSARCHIVOS MATLAB code for PlotPromediosArchivos.fig
%      PLOTPROMEDIOSARCHIVOS, by itself, creates a new PLOTPROMEDIOSARCHIVOS or raises the existing
%      singleton*.
%
%      H = PLOTPROMEDIOSARCHIVOS returns the handle to a new PLOTPROMEDIOSARCHIVOS or the handle to
%      the existing singleton*.
%
%      PLOTPROMEDIOSARCHIVOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTPROMEDIOSARCHIVOS.M with the given input arguments.
%
%      PLOTPROMEDIOSARCHIVOS('Property','Value',...) creates a new PLOTPROMEDIOSARCHIVOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PlotPromediosArchivos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PlotPromediosArchivos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotPromediosArchivos

% Last Modified by GUIDE v2.5 14-Oct-2018 13:33:21

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotPromediosArchivos_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotPromediosArchivos_OutputFcn, ...
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


% --- Executes just before PlotPromediosArchivos is made visible.
function PlotPromediosArchivos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PlotPromediosArchivos (see VARARGIN)

% Choose default command line output for PlotPromediosArchivos
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PlotPromediosArchivos wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = PlotPromediosArchivos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bandera Cv Names_Variable window FileName window2 Archivos

Archivos=get(handles.edit3,'String');
if isempty(Archivos) 
    fprintf('Error: Ingrese primero El # Archivos\n');
else
    Archivos=str2num(Archivos)
    for ii=1:Archivos
        [FileName{ii},PathName] = uigetfile('*.txt','Select the VISSIM network Results file');
        T = readtable(FileName{ii});
        [f size_Var]=size(T.Properties.VariableNames);
        Names_Variable=T.Properties.VariableNames;
        Cv{ii}=table2cell(T);
        C=Cv{ii};
        bandera=1;
        i=0;
        while i==0
            if size(cell2mat(C(bandera,2)))==size(cell2mat(C(bandera+1,2)))
                bandera=bandera+1;
            else
                i=1;
            end

        end
        Names_Road=C(1:bandera,3);
        set(handles.popupmenu1,'Visible','on')
        set(handles.text6,'Visible','on')
        set(handles.popupmenu1,'String',Names_Variable(4:end)');
        window=0;
        window2=0;
    end
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global Column Cv bandera Names_Variable window Datav FileName Archivos Colors
Column=get(hObject,'Value')+3
Row=get(handles.edit1,'String');
Colors=[0 0 0;
        0 0 1;
        0 1 0;
        0 1 1;
        1 0 0;
        1 0 1;
        0.5 0.5 0.5;
        0 0.2 0.5;
        0.5 0.5 0.2;
        1 0.5 0.2;
        0.7 0.5 0.4];
if isempty(Row) 
    fprintf('Error: Ingrese primero El # Calles\n');
else
    Row=str2num(Row)
    Row=Row+1;
    Nodes=get(handles.edit2,'String');
    if isempty(Nodes)
    fprintf('Error: Ingrese primero El # Nodes\n');
    else
        Nodes=str2num(Nodes);
        Data=[];
        for iii=1:Archivos
            C=Cv{iii};
            if Nodes==2
               [RowC ColC]=size(C);
                bandera2=0;
                
                Data2=[];
                i=0;

                while i==0
                    if ((Row+(bandera*bandera2))<RowC)
                        if size(cell2mat(C(Row+(bandera*bandera2),1)))==size(cell2mat(C(Row+(bandera*bandera2)+1,1)))
                            if cell2mat(C(Row+(bandera*bandera2),1))==cell2mat(C(Row+(bandera*bandera2)+1,1))
                                if isnan(cell2mat(C(Row+(bandera*bandera2),Column)))==1
                                    Data(bandera2+1)=0;
                                    bandera2=bandera2+1;
                                else
                                    Data(bandera2+1)=0;
                                    for ii=0:Nodes-1
                                        Data(bandera2+1)=Data(bandera2+1)+cell2mat(C(Row+(bandera*bandera2)+(19*ii),Column));                                        
                                    end
                                    bandera2=bandera2+1;
                                end
                            else
                                i=1;
                            end
                        else
                            i=1;
                        end
                    else
                        i=1;
                    end
                end

            else
                [RowC ColC]=size(C);
                bandera2=0;
                Data=[];
                i=0;
                while i==0
                    if ((Row+(bandera*bandera2))<RowC)
                        if size(cell2mat(C(Row+(bandera*bandera2),1)))==size(cell2mat(C(Row+(bandera*bandera2)+1,1)))
                            if cell2mat(C(Row+(bandera*bandera2),1))==cell2mat(C(Row+(bandera*bandera2)+1,1))
                                if isnan(cell2mat(C(Row+(bandera*bandera2),Column)))==1
                                    Data(bandera2+1)=0;
                                    bandera2=bandera2+1;
                                else
                                    Data(bandera2+1)=0;
                                    for ii=0:Nodes-1
                                        Data(bandera2+1)=Data(bandera2+1)+cell2mat(C(Row+(bandera*bandera2)+(Row*ii),Column));
                                    end
                                    bandera2=bandera2+1;
                                end
                            else
                                i=1;
                            end
                        else
                            i=1;
                        end
                    else
                        i=1;
                    end
                end
            end
            Datav{iii}=Data;
        end
 
        window = window + 1;
        if window>1
            close Figure 1
        end
        figure(1)
        for i=1:Archivos
            plot(Datav{i},'Color',Colors(i,:))
            grid on
            hold on
        end
        title('Vissim Data Mean Plot ');
        ylabel(cell2mat(Names_Variable(Column)));
        xlabel('Time Intervals');
        legend(FileName);
        set(handles.pushbutton2,'Visible','on')
    end
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Datav FileName window2 Archivos Colors
for i=1:Archivos
    Dataprom{i}=cumtrapz(Datav{i});
end
window2=window2+1;
if window2>1
    close Figure 2
end
figure(2)
for i=1:Archivos
    plot(Dataprom{i},'Color',Colors(i,:),'LineWidth',2)
    hold on
    grid on
end
xlabel('Time Intervals');
%title('Integral');
ylabel('Integral promedio de Datos Vissim');
legend(FileName);
grid on
