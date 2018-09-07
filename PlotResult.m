function varargout = PlotResult(varargin)
% PLOTRESULT MATLAB code for PlotResult.fig
%      PLOTRESULT, by itself, creates a new PLOTRESULT or raises the existing
%      singleton*.
%
%      H = PLOTRESULT returns the handle to a new PLOTRESULT or the handle to
%      the existing singleton*.
%
%      PLOTRESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTRESULT.M with the given input arguments.
%
%      PLOTRESULT('Property','Value',...) creates a new PLOTRESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PlotResult_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PlotResult_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotResult

% Last Modified by GUIDE v2.5 30-Aug-2018 20:39:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotResult_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotResult_OutputFcn, ...
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


% --- Executes just before PlotResult is made visible.
function PlotResult_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PlotResult (see VARARGIN)

% Choose default command line output for PlotResult
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PlotResult wait for user response (see UIRESUME)
% uiwait(handles.figure1);
helpdlg('Este programa permite comparar dos series de datos dentro de una tabla de datos dada por Vissim. Seleccionar primero la Variable 1 y luego la Variable 2 para evitar problemas.')


% --- Outputs from this function are returned to the command line.
function varargout = PlotResult_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in FileButton.
function FileButton_Callback(hObject, eventdata, handles)
% hObject    handle to FileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bandera C Names_Variable window FileName1
set(handles.popupmenu1,'Visible','off')
set(handles.text5,'Visible','off')
[FileName1,PathName] = uigetfile('*.txt','Select the VISSIM network Results file');
set(handles.Text_FileName,'String',FileName1)
T = readtable(FileName1);
[f size_Var]=size(T.Properties.VariableNames);
Names_Variable=T.Properties.VariableNames
C=table2cell(T);
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
set(handles.popupmenu2,'Visible','on')
set(handles.text6,'Visible','on')
set(handles.popupmenu2,'String',Names_Road);
set(handles.popupmenu1,'String',Names_Variable(4:end)');
window=0;



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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global Column Row C bandera Names_Variable window Data1
set(handles.pushbutton3,'Visible','off')
Column=get(hObject,'Value')+3
[RowC ColC]=size(C);
bandera2=0;
Data=[];
i=0;
while i==0
    if ((Row+(bandera*bandera2))<RowC)
        if size(cell2mat(C(Row+(bandera*bandera2),1)))==size(cell2mat(C(Row+(bandera*bandera2)+1,1)))
            if cell2mat(C(Row+(bandera*bandera2),1))==cell2mat(C(Row+(bandera*bandera2)+1,1))
                if isnan(cell2mat(C(Row+(bandera*bandera2),Column)))==1
                    i=1;
                else
                    Data(bandera2+1)=cell2mat(C(Row+(bandera*bandera2),Column));
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
Promedio=mean(Data);
strPromedio=num2str(Promedio);
set(handles.text9,'String',strPromedio);
Minimo=min(Data);
strMinimo=num2str(Minimo);
set(handles.text13,'String',strMinimo);
Maximo=max(Data);
strMaximo=num2str(Maximo);
set(handles.text11,'String',strMaximo);
window=window+1
if window>1
    close Figure 1
end
Data1=Data;
figure(1)
plot(Data,'b')
grid on
hold on
title('Vissim Data Plot');
ylabel(cell2mat(Names_Variable(Column)));
xlabel('Time Intervals');



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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global Row
set(handles.popupmenu1,'Visible','on')
set(handles.text5,'Visible','on')
Row=get(hObject,'Value')


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
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
global bandera2 C2 Names_Variable2 FileName2

set(handles.text17,'Visible','off')
[FileName2,PathName] = uigetfile('*.txt','SeleC2t the VISSIM network Results file');
set(handles.text16,'String',FileName2)
T = readtable(FileName2);
[f size_Var]=size(T.Properties.VariableNames);
Names_Variable2=T.Properties.VariableNames
C2=table2cell(T);
bandera2=1;
i=0;
while i==0
    if size(cell2mat(C2(bandera2,2)))==size(cell2mat(C2(bandera2+1,2)))
        bandera2=bandera2+1;
    else
        i=1;
    end
    
end
Names_Road=C2(1:bandera2,3);
set(handles.popupmenu4,'Visible','on')
set(handles.text18,'Visible','on')
set(handles.popupmenu4,'String',Names_Road);
set(handles.popupmenu3,'String',Names_Variable2(4:end)');


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
global Data2 Column2 Row2 C2 bandera2 Names_Variable2 FileName2 FileName1
Column2=get(hObject,'Value')+3
[RowC ColC]=size(C2);
bandera3=0;
Data=[];
i=0;
while i==0
    if ((Row2+(bandera2*bandera3))<RowC)
        if size(cell2mat(C2(Row2+(bandera2*bandera3),1)))==size(cell2mat(C2(Row2+(bandera2*bandera3)+1,1)))
            if cell2mat(C2(Row2+(bandera2*bandera3),1))==cell2mat(C2(Row2+(bandera2*bandera3)+1,1))
                if isnan(cell2mat(C2(Row2+(bandera2*bandera3),Column2)))==1
                    i=1;
                else
                    Data(bandera3+1)=cell2mat(C2(Row2+(bandera2*bandera3),Column2));
                    bandera3=bandera3+1;
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
Promedio=mean(Data);
strPromedio=num2str(Promedio);
set(handles.text20,'String',strPromedio);
Minimo=min(Data);
strMinimo=num2str(Minimo);
set(handles.text24,'String',strMinimo);
Maximo=max(Data);
strMaximo=num2str(Maximo);
set(handles.text22,'String',strMaximo);
Data2=Data;
figure(1)
plot(Data,'r')
grid on
hold on
ylabel(cell2mat(Names_Variable2(Column2)));
xlabel('Time Intervals');
legend(FileName1,FileName2);


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
global Row2
set(handles.popupmenu3,'Visible','on')
set(handles.text17,'Visible','on')
Row2=get(hObject,'Value')

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Data2 Data1 Data3 FileName1 FileName2 FileName3
Data1=cumtrapz(Data1);
Data2=cumtrapz(Data2);
Data3=cumtrapz(Data3);
figure(2)
plot(Data1,'b','LineWidth',2)
hold on
plot(Data2,'r','LineWidth',2)
hold on
plot(Data3,'g','LineWidth',2)
xlabel('Time Intervals');
title('Integral');
ylabel('Power');
legend(FileName1,FileName2,FileName3);
grid on


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bandera3 C3 Names_Variable3 FileName3

set(handles.text37,'Visible','on')
[FileName3,PathName] = uigetfile('*.txt','SeleC2t the VISSIM network Results file');
set(handles.text36,'String',FileName3)
T = readtable(FileName3);
[f size_Var]=size(T.Properties.VariableNames);
Names_Variable3=T.Properties.VariableNames
C3=table2cell(T);
bandera3=1;
i=0;
while i==0
    if size(cell2mat(C3(bandera3,2)))==size(cell2mat(C3(bandera3+1,2)))
        bandera3=bandera3+1;
    else
        i=1;
    end
    
end
Names_Road=C3(1:bandera3,3);
set(handles.popupmenu8,'Visible','on')
set(handles.text38,'Visible','on')
set(handles.popupmenu8,'String',Names_Road);
set(handles.popupmenu7,'String',Names_Variable3(4:end)');

% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
global Data3 Column3 Row3 C3 bandera3 Names_Variable3 FileName2 FileName1 FileName3
Column3=get(hObject,'Value')+3
[RowC ColC]=size(C3);
bandera4=0;
Data=[];
i=0;
while i==0
    if ((Row3+(bandera3*bandera4))<RowC)
        if size(cell2mat(C3(Row3+(bandera3*bandera4),1)))==size(cell2mat(C3(Row3+(bandera3*bandera4)+1,1)))
            if cell2mat(C3(Row3+(bandera3*bandera4),1))==cell2mat(C3(Row3+(bandera3*bandera4)+1,1))
                if isnan(cell2mat(C3(Row3+(bandera3*bandera4),Column3)))==1
                    i=1;
                else
                    Data(bandera4+1)=cell2mat(C3(Row3+(bandera3*bandera4),Column3));
                    bandera4=bandera4+1;
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
Promedio=mean(Data);
strPromedio=num2str(Promedio);
set(handles.text40,'String',strPromedio);
Minimo=min(Data);
strMinimo=num2str(Minimo);
set(handles.text44,'String',strMinimo);
Maximo=max(Data);
strMaximo=num2str(Maximo);
set(handles.text42,'String',strMaximo);
Data3=Data;
figure(1)
plot(Data,'g')
grid on
hold on
ylabel(cell2mat(Names_Variable3(Column3)));
xlabel('Time Intervals');
legend(FileName1,FileName2,FileName3);
set(handles.pushbutton3,'Visible','on')


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8
global Row3
set(handles.popupmenu7,'Visible','on')
set(handles.text37,'Visible','on')
Row3=get(hObject,'Value')

% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
