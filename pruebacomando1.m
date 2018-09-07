%% Vissim-COM programming - example code %%
clear all;
close all;
clc; % Clears the command window
%% Create Vissim-COM server
vis=actxserver('VISSIM.vissim.100');
%% Cargando red de trafico
ruta_actual=pwd;
vis.LoadNet([ruta_actual '\test1.inpx']);
vis.LoadLayout([ruta_actual '\test1.layx']);
%% Parametros de Simulación
sim=vis.Simulation;
period_time = 22500;%6.25hrs
random_seed = 42;
sim.set('AttValue','SimPeriod', period_time);
sim.set('AttValue','RandSeed', random_seed);
step_time = 1;
sim.set('AttValue','SimRes', step_time);
%% Definir la red como objeto
vnet = vis.Net;
%% Configurando demanda de trafico
q1 = 1000; %flujo de entrada
q2 = 1000; %Flujo de entrada
q3 = 1000; %Flujo de entrada
q4 = 1000;%Flujo de entrada
vehins = vnet.VehicleInputs;
vehin_1 = vehins.ItemByKey(1);
vehin_1.set('AttValue','Volume(1)',q1);
vehin_2 = vehins.ItemByKey(2);
vehin_2.set('AttValue','Volume(1)',q2);
vehin_3 = vehins.ItemByKey(3);
vehin_3.set('AttValue','Volume(1)',q3); 
vehin_4 = vehins.ItemByKey(4);
vehin_4.set('AttValue','Volume(1)',q4);
%% Simulacion principal
for i=1:period_time
 sim.RunSingleStep;
 
 
tiempo = sim.get('AttValue', 'SimSec');
  
%% para cambiar flujos de trafico durante la simulación
  switch tiempo
      case 4500
        q1 = 1500; %flujo de entrada
        q2 = 1000; %Flujo de entrada
        q3 = 1500;%Flujo de entrada
        q4 = 1000;%Flujo de entrada
        vehins = vnet.VehicleInputs;
        vehin_1 = vehins.ItemByKey(1);
        vehin_1.set('AttValue','Volume(1)',q1);
        vehin_2 = vehins.ItemByKey(2);
        vehin_2.set('AttValue','Volume(1)',q2);
        vehin_3 = vehins.ItemByKey(3);
        vehin_3.set('AttValue','Volume(1)',q3);
        vehin_4 = vehins.ItemByKey(4);
        vehin_4.set('AttValue','Volume(1)',q4);
        
      case 9000
        q1 = 1000; %flujo de entrada
        q2 = 1500; %Flujo de entrada
        q3 = 1000;%Flujo de entrada
        q4 = 1500;%Flujo de entrada
        vehins = vnet.VehicleInputs;
        vehin_1 = vehins.ItemByKey(1);
        vehin_1.set('AttValue','Volume(1)',q1);
        vehin_2 = vehins.ItemByKey(2);
        vehin_2.set('AttValue','Volume(1)',q2);
        vehin_3 = vehins.ItemByKey(3);
        vehin_3.set('AttValue','Volume(1)',q3);
        vehin_4 = vehins.ItemByKey(4);
        vehin_4.set('AttValue','Volume(1)',q4);
        
        case 13500
        q1 = 1000; %flujo de entrada
        q2 = 500; %Flujo de entrada
        q3 = 1000;%Flujo de entrada
        q4 = 500;%Flujo de entrada
        vehins = vnet.VehicleInputs;
        vehin_1 = vehins.ItemByKey(1);
        vehin_1.set('AttValue','Volume(1)',q1);
        vehin_2 = vehins.ItemByKey(2);
        vehin_2.set('AttValue','Volume(1)',q2);
        vehin_3 = vehins.ItemByKey(3);
        vehin_3.set('AttValue','Volume(1)',q3);
        vehin_4 = vehins.ItemByKey(4);
        vehin_4.set('AttValue','Volume(1)',q4);
        
        case 18000
        q1 = 500; %flujo de entrada
        q2 = 1000; %Flujo de entrada
        q3 = 500;%Flujo de entrada
        q4 = 1000;%Flujo de entrada
        vehins = vnet.VehicleInputs;
        vehin_1 = vehins.ItemByKey(1);
        vehin_1.set('AttValue','Volume(1)',q1);
        vehin_2 = vehins.ItemByKey(2);
        vehin_2.set('AttValue','Volume(1)',q2);
        vehin_3 = vehins.ItemByKey(3);
        vehin_3.set('AttValue','Volume(1)',q3);
        vehin_4 = vehins.ItemByKey(4);
        vehin_4.set('AttValue','Volume(1)',q4);

             

  end


      
     
 end
%% Delete Vissim-COM server (also closes the Vissim GUI)
vis.release;
disp('The end')