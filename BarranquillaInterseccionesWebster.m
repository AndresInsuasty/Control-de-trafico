%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       UNIVERSIDAD DE NARIÑO                             %
%                       Facultad de Ingenieria                            %
%                                                                         %
% Este es un programa para la simulación de dos intersecciones de trafico %
% en la version 10.0 de vissim                                            %
% Contacto: Andres Insuasty Correo: andresinsuastyd10@gmail.com           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vissim-COM programming 
clear all;
close all;
clc; % Clears the command window
%% Create Vissim-COM server
vis=actxserver('VISSIM.vissim.100');
%% Cargando red de trafico
ruta_actual=pwd;
vis.LoadNet([ruta_actual '\RedBarranquilla.inpx']);
vis.LoadLayout([ruta_actual '\RedBarranquilla.layx']);
%% Definir la red como objeto
vnet = vis.Net;
%% Configurando demanda de trafico
flujo=1000;
q1 = 1000; %flujo de entrada
q2 = flujo/2; %Flujo de entrada
q3 = flujo/2; %Flujo de entrada
q4 = flujo;%Flujo de entrada
q5 = 1000;
q6 = flujo;
q7 = flujo;
vehins = vnet.VehicleInputs;
vehin_1 = vehins.ItemByKey(1);
vehin_1.set('AttValue','Volume(1)',q1); 
vehin_2 = vehins.ItemByKey(2);
vehin_2.set('AttValue','Volume(1)',q2); 
vehin_3 = vehins.ItemByKey(3);
vehin_3.set('AttValue','Volume(1)',q3);
vehin_4 = vehins.ItemByKey(4);
vehin_4.set('AttValue','Volume(1)',q4);
vehin_5 = vehins.ItemByKey(5);
vehin_5.set('AttValue','Volume(1)',q5);
vehin_6 = vehins.ItemByKey(6);
vehin_6.set('AttValue','Volume(1)',q6);
vehin_7 = vehins.ItemByKey(7);
vehin_7.set('AttValue','Volume(1)',q7);

%% Parametros de Simulación
sim=vis.Simulation;
period_time = 3600;
random_seed = 42;
sim.set('AttValue','SimPeriod', period_time);
sim.set('AttValue','RandSeed', random_seed);
step_time = 1;
sim.set('AttValue','SimRes', step_time);
tiempo = 0;

%% Simulacion principal
while tiempo<=period_time
 sim.RunSingleStep;
 tiempo = sim.get('AttValue', 'SimSec');
 
 
 
    
    %% para cambiar flujos de trafico durante la simulación
%   switch tiempo
%       case 1200
%         flujo=2400;
%         q1 = 1000; %flujo de entrada
%         q2 = flujo/2; %Flujo de entrada
%         q3 = flujo/2; %Flujo de entrada
%         q4 = flujo;%Flujo de entrada
%         q5 = 1000;
%         q6 = flujo;
%         q7 = flujo;
%         vehins = vnet.VehicleInputs;
%         vehin_1 = vehins.ItemByKey(1);
%         vehin_1.set('AttValue','Volume(1)',q1); 
%         vehin_2 = vehins.ItemByKey(2);
%         vehin_2.set('AttValue','Volume(1)',q2); 
%         vehin_3 = vehins.ItemByKey(3);
%         vehin_3.set('AttValue','Volume(1)',q3);
%         vehin_4 = vehins.ItemByKey(4);
%         vehin_4.set('AttValue','Volume(1)',q4);
%         vehin_5 = vehins.ItemByKey(5);
%         vehin_5.set('AttValue','Volume(1)',q5);
%         vehin_6 = vehins.ItemByKey(6);
%         vehin_6.set('AttValue','Volume(1)',q6);
%         vehin_7 = vehins.ItemByKey(7);
%         vehin_7.set('AttValue','Volume(1)',q7);
%         
%       case 2400
%         flujo=1000;
%         q1 = 2400; %flujo de entrada
%         q2 = flujo/2; %Flujo de entrada
%         q3 = flujo/2; %Flujo de entrada
%         q4 = flujo;%Flujo de entrada
%         q5 = 2400;
%         q6 = flujo;
%         q7 = flujo;
%         vehins = vnet.VehicleInputs;
%         vehin_1 = vehins.ItemByKey(1);
%         vehin_1.set('AttValue','Volume(1)',q1); 
%         vehin_2 = vehins.ItemByKey(2);
%         vehin_2.set('AttValue','Volume(1)',q2); 
%         vehin_3 = vehins.ItemByKey(3);
%         vehin_3.set('AttValue','Volume(1)',q3);
%         vehin_4 = vehins.ItemByKey(4);
%         vehin_4.set('AttValue','Volume(1)',q4);
%         vehin_5 = vehins.ItemByKey(5);
%         vehin_5.set('AttValue','Volume(1)',q5);
%         vehin_6 = vehins.ItemByKey(6);
%         vehin_6.set('AttValue','Volume(1)',q6);
%         vehin_7 = vehins.ItemByKey(7);
%         vehin_7.set('AttValue','Volume(1)',q7);
%   end
%     
    if tiempo==period_time-1
        vis.release;
        disp('The end')
    end
end

