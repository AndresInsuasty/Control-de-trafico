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
%% Semaforos
scs = vnet.SignalControllers;
sc = scs.ItemByKey(1);
sgs = sc.SGs; %SGs=SigalGroups
sg_1 = sgs.ItemByKey(1);
sg_2 = sgs.ItemByKey(2);
sg_3 = sgs.ItemByKey(3);
sg_4 = sgs.ItemByKey(4);

%% configurando calles
links=vnet.Links;
link_1=links.ItemByKey(1);
%% Inicializacion de parametros
tiempoCiclo=115*step_time; %tiempo de rojo+verde de la fase de los semaforos, tiempo*step_time

flujo_inicial1 = 0;
flujo_inicial2 = 0;
flujo_inicial3 = 0;
flujo_inicial4 = 0;
flujo_final1 = 0;
flujo_final2 = 0;
flujo_final3 = 0;
flujo_final4 = 0;

cola1 = vnet.QueueCounter.ItemByKey(1);
cola2 = vnet.QueueCounter.ItemByKey(2);
cola3 = vnet.QueueCounter.ItemByKey(3);
cola4 = vnet.QueueCounter.ItemByKey(4);
cola5 = vnet.QueueCounter.ItemByKey(5);
cola6 = vnet.QueueCounter.ItemByKey(6);
cola7 = vnet.QueueCounter.ItemByKey(7);
cola8 = vnet.QueueCounter.ItemByKey(8);

contador=0;
Tspan = 1000;
x0 = (tiempoCiclo/4)*[1 1 1 1]; %tiempos iniciales para semaforos
s_flujo = [172 289 228 255]; %valores de saturacion de las calles
s_queue = [100 130 100 130];
qin = [0 0 0 0];
x = x0;

%% Simulacion principal
for i=0:((period_time*step_time)-2)
 sim.RunSingleStep;
 
 
%  if contador == 0   %Flujo de trafico al inicio de cada ciclo
%      flujo_inicial1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
%      flujo_inicial2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
%  end
 %s = [1400 1500]; %Saturacion de carretera medidos
 
 semaforo1 = round(x(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo2 = round(x(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo3 = round(x(end,3)); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo4 = round(x(end,4)); %tiempo*step_time para verde semaforo 4 (horizontal)
 %semaforo1 = 0.8*tiempoCiclo*step_time; %tiempo*step_time para verde semaforo 1
 %semaforo2 = tiempoCiclo-semaforo1; %con esta resta se asegura el ciclo sea "tiempoCiclo"
 
     if contador<=semaforo1
         if (contador==0)
              sg_1.set('AttValue','State',2); % 1:rojo 2:amarillo 3:verde
              sim.RunSingleStep;
              contador=contador+1;
         end
        
         sg_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador>semaforo1)&&(contador<=(semaforo1+semaforo2))
         if (contador==(semaforo1+1))
              sg_2.set('AttValue','State',2); % 1:rojo 2:amarillo 3:verde
              sim.RunSingleStep;
              contador=contador+1;
         end
         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
     elseif (contador > (semaforo1+semaforo2) )&&(contador <= (semaforo1+semaforo2+semaforo3) )
         if (contador==(semaforo1+semaforo2+1))
              sg_3.set('AttValue','State',2); % 1:rojo 2:amarillo 3:verde
              sim.RunSingleStep;
              contador=contador+1;
         end
         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
     elseif (contador > (semaforo1+semaforo2+semaforo3) )&&(contador <=tiempoCiclo)
         if (contador==(semaforo1+semaforo2+semaforo3+1))
              sg_4.set('AttValue','State',2); % 1:rojo 2:amarillo 3:verde
              sim.RunSingleStep;
              contador=contador+1;
         end
         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
     end
     
     contador = contador+1;
     
     if contador == tiempoCiclo-1 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         flujo_final1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
         flujo_final2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
         flujo_final3 = vnet.DataCollectionMeasurement.ItemByKey(3).AttValue('Vehs(Current,Current,All)');
         flujo_final4 = vnet.DataCollectionMeasurement.ItemByKey(4).AttValue('Vehs(Current,Current,All)');
         
         v1 = cola1.AttValue('QlenMax(Current,Current)');
         v2 = cola2.AttValue('QlenMax(Current,Current)');
         v3 = cola3.AttValue('QlenMax(Current,Current)');
         v4 = cola4.AttValue('QlenMax(Current,Current)');
         v5 = cola5.AttValue('QlenMax(Current,Current)');
         v6 = cola6.AttValue('QlenMax(Current,Current)');
         v7 = cola7.AttValue('QlenMax(Current,Current)');
         v8 = cola8.AttValue('QlenMax(Current,Current)');
         
         qin = double([flujo_final1-flujo_inicial1 flujo_final2-flujo_inicial2 flujo_final3-flujo_inicial3 flujo_final4-flujo_inicial4]);
         
         queue = [v1 v2+v3+v7 v4 v5+v6+v8];
         
         [t,x] = ode23s('replicator_equation_F_Q',Tspan,x0,[],qin,queue,s_flujo,s_queue,tiempoCiclo);
         disp(x(end,:));
 
         flujo_inicial1 = flujo_final1;
         flujo_inicial2 = flujo_final2;
         flujo_inicial3 = flujo_final3;
         flujo_inicial4 = flujo_final4;
              
     end
    if contador == tiempoCiclo
        contador=0;
    end 
     
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