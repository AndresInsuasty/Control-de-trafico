%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       UNIVERSIDAD DE NARIÑO                             %
%                       Facultad de Ingenieria                            %
%                                                                         %
% Este es un programa para la simulación de dos intersecciones de trafico %
% en la version 10.0 de vissim, el algortimo empleado es el de replicador %
% dinamico, uno en cada intersección con poblacion igual n=4, se reparte  %
% "los nutrientes" segun la ecuacion diferencial que es el tiempo de ciclo%
% de cada intersección.                                                   %
% La interseccion en simulación es adapatada e inspirada de la via        %
% panamericana en la ciudad de Pasto con coordenadas 1.207904, -77.288786 %
%                                                                         %
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
vis.LoadNet([ruta_actual '\2interseccionesPasto.inpx']);
vis.LoadLayout([ruta_actual '\2interseccionesPasto.layx']);
%% Parametros de Simulación
sim=vis.Simulation;
period_time = 5*3600;
random_seed = 42;
sim.set('AttValue','SimPeriod', period_time);
sim.set('AttValue','RandSeed', random_seed);
step_time = 1;
sim.set('AttValue','SimRes', step_time);
%% Definir la red como objeto
vnet = vis.Net;
%% Configurando demanda de trafico
q1 = 500; %flujo de entrada
q2 = 2000; %Flujo de entrada
q3 = 1500; %Flujo de entrada
q4 = 250;%Flujo de entrada
q5 = 1800;
q6 = 500;

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

%% Semaforos
scs = vnet.SignalControllers;

sc1 = scs.ItemByKey(1);
sgs1 = sc1.SGs; %SGs=SigalGroups
sg1_1 = sgs1.ItemByKey(1);
sg1_2 = sgs1.ItemByKey(2);
sg1_3 = sgs1.ItemByKey(3);
sg1_4 = sgs1.ItemByKey(4);

sc2 = scs.ItemByKey(2);
sgs2 = sc2.SGs;
sg2_1 = sgs2.ItemByKey(1);
sg2_2 = sgs2.ItemByKey(2);
sg2_3 = sgs2.ItemByKey(3);
sg2_4 = sgs2.ItemByKey(4);

%% configurando calles
links=vnet.Links;
link_1=links.ItemByKey(1);
%% Inicializacion de parametros
tiempoCiclo=115*step_time; %tiempo de rojo+verde de la fase de los semaforos, tiempo*step_time

flujo1_inicial1 = 0;
flujo1_inicial2 = 0;
flujo1_inicial3 = 0;
flujo1_inicial4 = 0;
flujo1_final1 = 0;
flujo1_final2 = 0;
flujo1_final3 = 0;
flujo1_final4 = 0;

flujo2_inicial1 = 0;
flujo2_inicial2 = 0;
flujo2_inicial3 = 0;
flujo2_inicial4 = 0;
flujo2_final1 = 0;
flujo2_final2 = 0;
flujo2_final3 = 0;
flujo2_final4 = 0;

contador=0;
Tspan = 1000;
x10 = (tiempoCiclo/4)*[1 1 1 1]; %tiempos iniciales para semaforos
s1 = [182 289 228 255]; %valores de saturacion de las calles
qin1 = [0 0 0 0];
x1 = x10;

x20 = (tiempoCiclo/4)*[1 1 1 1]; %tiempos iniciales para semaforos
%s2 = [379 364 52.5 383]; %valores de saturacion de las calles
s2 = [190 289 90 200]; %valores de saturacion de las calles
qin2 = [0 0 0 0];
x2 = x20;

%% Simulacion principal
for i=0:((period_time*step_time)-2)
 sim.RunSingleStep;
 
%  if contador == 0   %Flujo de trafico al inicio de cada ciclo
%      flujo_inicial1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
%      flujo_inicial2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
%  end
 %s = [1400 1500]; %Saturacion de carretera medidos
 
 %INTERSECCION 1
 semaforo11 = round(x1(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo12 = round(x1(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo13 = round(x1(end,3)); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo14 = round(x1(end,4)); %tiempo*step_time para verde semaforo 4 (horizontal)
 %semaforo1 = 0.8*tiempoCiclo*step_time; %tiempo*step_time para verde semaforo 1
 %semaforo2 = tiempoCiclo-semaforo1; %con esta resta se asegura el ciclo sea "tiempoCiclo"
 
 %INTERSECCION 2
 semaforo21 = round(x2(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo22 = round(x2(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo23 = round(x2(end,3)); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo24 = round(x2(end,4)); %tiempo*step_time para verde semaforo 4 (horizontal)
 
 % ASIGNACION ESTADOS INTERSECCION 1 
     if contador<=semaforo11   
         sg1_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg1_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador>semaforo11)&&(contador<=(semaforo11+semaforo12))
         sg1_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg1_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador > (semaforo11+semaforo12) )&&(contador <= (semaforo11+semaforo12+semaforo13) )
         sg1_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_3.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg1_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador > (semaforo11+semaforo12+semaforo13) )&&(contador <=tiempoCiclo)
         sg1_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_4.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
     end
     
   % ASIGNACION ESTADOS INTERSECCION 2 
     if contador<=semaforo21   
         sg2_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg2_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador>semaforo21)&&(contador<=(semaforo21+semaforo22))
         sg2_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg2_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador > (semaforo21+semaforo22) )&&(contador <= (semaforo21+semaforo22+semaforo23) )
         sg2_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_3.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg2_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador > (semaforo21+semaforo22+semaforo23) )&&(contador <=tiempoCiclo)
         sg2_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_4.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
     end
     contador = contador+1;
     
     if contador == tiempoCiclo % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         
         %INTERSECCION 1 FLUJOS
         flujo1_final1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
         flujo1_final2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
         flujo1_final3 = vnet.DataCollectionMeasurement.ItemByKey(3).AttValue('Vehs(Current,Current,All)');
         flujo1_final4 = vnet.DataCollectionMeasurement.ItemByKey(4).AttValue('Vehs(Current,Current,All)');
         qin1 = double([flujo1_final1-flujo1_inicial1 flujo1_final2-flujo1_inicial2 flujo1_final3-flujo1_inicial3 flujo1_final4-flujo1_inicial4]);
         
         %INTERSECCION 2 FLUJOS
         flujo2_final1 = vnet.DataCollectionMeasurement.ItemByKey(5).AttValue('Vehs(Current,Current,All)');
         flujo2_final2 = vnet.DataCollectionMeasurement.ItemByKey(6).AttValue('Vehs(Current,Current,All)');
         flujo2_final3 = vnet.DataCollectionMeasurement.ItemByKey(7).AttValue('Vehs(Current,Current,All)');
         flujo2_final4 = vnet.DataCollectionMeasurement.ItemByKey(8).AttValue('Vehs(Current,Current,All)');
         qin2 = double([flujo2_final1-flujo2_inicial1 flujo2_final2-flujo2_inicial2 flujo2_final3-flujo2_inicial3 flujo2_final4-flujo2_inicial4]);
         
         
         [t1,x1] = ode23s('replicator_equation',Tspan,x10,[],qin1,s1,tiempoCiclo);
         disp('Interseccion 1:');
         disp(x1(end,:));
         
         [t2,x2] = ode23s('replicator_equation',Tspan,x20,[],qin2,s2,tiempoCiclo);
         disp('Interseccion 2:');
         disp(x2(end,:));
         
         %INTERSECCION 1
         flujo1_inicial1 = flujo1_final1;
         flujo1_inicial2 = flujo1_final2;
         flujo1_inicial3 = flujo1_final3;
         flujo1_inicial4 = flujo1_final4;
         
         %INTERSECCION 2
         flujo2_inicial1 = flujo2_final1;
         flujo2_inicial2 = flujo2_final2;
         flujo2_inicial3 = flujo2_final3;
         flujo2_inicial4 = flujo2_final4;
              
         contador=0;
     end
  tiempo = sim.get('AttValue', 'SimSec');
  
% %% para cambiar flujos de trafico durante la simulación
%   switch tiempo
%       case 500
%         q1 = 300; %flujo de entrada
%         q2 = 10000; %Flujo de entrada
%         q3 = 300;%Flujo de entrada
%         q4 = 300;%Flujo de entrada
%         vehins = vnet.VehicleInputs;
%         vehin_1 = vehins.ItemByKey(1);
%         vehin_1.set('AttValue','Volume(1)',q1);
%         vehin_2 = vehins.ItemByKey(2);
%         vehin_2.set('AttValue','Volume(1)',q2);
%         vehin_3 = vehins.ItemByKey(3);
%         vehin_3.set('AttValue','Volume(1)',q3);
%         vehin_4 = vehins.ItemByKey(4);
%         vehin_4.set('AttValue','Volume(1)',q4);
%         
%       case 1000
%         q1 = 500; %flujo de entrada
%         q2 = 500; %Flujo de entrada
%         q3 = 500;%Flujo de entrada
%         q4 = 500;%Flujo de entrada
%         vehins = vnet.VehicleInputs;
%         vehin_1 = vehins.ItemByKey(1);
%         vehin_1.set('AttValue','Volume(1)',q1);
%         vehin_2 = vehins.ItemByKey(2);
%         vehin_2.set('AttValue','Volume(1)',q2);
%         vehin_3 = vehins.ItemByKey(3);
%         vehin_3.set('AttValue','Volume(1)',q3);
%         vehin_4 = vehins.ItemByKey(4);
%         vehin_4.set('AttValue','Volume(1)',q4);
% 
%       case 1500
%         q1 = 1000; %flujo de entrada
%         q2 = 1000; %Flujo de entrada
%         q3 = 1000;%Flujo de entrada
%         q4 = 1000;%Flujo de entrada
%         vehins = vnet.VehicleInputs;
%         vehin_1 = vehins.ItemByKey(1);
%         vehin_1.set('AttValue','Volume(1)',q1);
%         vehin_2 = vehins.ItemByKey(2);
%         vehin_2.set('AttValue','Volume(1)',q2);
%         vehin_3 = vehins.ItemByKey(3);
%         vehin_3.set('AttValue','Volume(1)',q3);
%         vehin_4 = vehins.ItemByKey(4);
%         vehin_4.set('AttValue','Volume(1)',q4);
%         
%       case 2000
%         q1 = 1200; %flujo de entrada
%         q2 = 1200; %Flujo de entrada
%         q3 = 1200;%Flujo de entrada
%         q4 = 1200;%Flujo de entrada
%         vehins = vnet.VehicleInputs;
%         vehin_1 = vehins.ItemByKey(1);
%         vehin_1.set('AttValue','Volume(1)',q1);
%         vehin_2 = vehins.ItemByKey(2);
%         vehin_2.set('AttValue','Volume(1)',q2);
%         vehin_3 = vehins.ItemByKey(3);
%         vehin_3.set('AttValue','Volume(1)',q3);
%         vehin_4 = vehins.ItemByKey(4);
%         vehin_4.set('AttValue','Volume(1)',q4);         
% 
%   end


      
     
 end
%% Delete Vissim-COM server (also closes the Vissim GUI)
vis.release;
disp('The end')