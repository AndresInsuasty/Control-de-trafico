%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       UNIVERSIDAD DE NARI?O                             %
%                       Facultad de Ingenieria                            %
%                                                                         %
% Este es un programa para la simulaci?n de dos intersecciones de trafico %
% en la version 10.0 de vissim, el algortimo empleado es el de replicador %
% dinamico, uno en cada intersecci?n con poblacion igual n=4, se reparte  %
% "los nutrientes" segun la ecuacion diferencial que es el tiempo de ciclo%
% de cada intersecci?n.                                                   %
% La interseccion en simulaci?n es adapatada e inspirada de la via        %
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
vis.LoadNet([ruta_actual '\red de sincronizacion.inpx']);
vis.LoadLayout([ruta_actual '\red de sincronizacion.layx']);
%% Definir la red como objeto
vnet = vis.Net;
%% Configurando demanda de trafico
flujo=1000;
q1 = 1000; %flujo de entrada
q2 = 500; %Flujo de entrada
q3 = 500; %Flujo de entrada
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

%% Parametros de Simulaci?n
sim=vis.Simulation;
period_time = 3600;
random_seed = 42;
sim.set('AttValue','SimPeriod', period_time);
sim.set('AttValue','RandSeed', random_seed);
step_time = 1;
sim.set('AttValue','SimRes', step_time);
%% Definir la red como objeto
vnet = vis.Net;

%% Semaforos
scs = vnet.SignalControllers;

sc1 = scs.ItemByKey(1);
sgs1 = sc1.SGs; %SGs=SigalGroups
sg1_1 = sgs1.ItemByKey(1);
sg1_2 = sgs1.ItemByKey(2);

sc2 = scs.ItemByKey(2);
sgs2 = sc2.SGs;
sg2_1 = sgs2.ItemByKey(1);
sg2_2 = sgs2.ItemByKey(2);

sc3 = scs.ItemByKey(3);
sgs3 = sc3.SGs;
sg3_1 = sgs3.ItemByKey(1);
sg3_2 = sgs3.ItemByKey(2);

%% Inicializacion de parametros
tiempoCiclo=115*step_time; %tiempo de rojo+verde de la fase de los semaforos, tiempo*step_time

flujo1_inicial1 = 0;
flujo1_inicial2 = 0;
flujo1_final1 = 0;
flujo1_final2 = 0;

flujo2_inicial1 = 0;
flujo2_inicial2 = 0;
flujo2_final1 = 0;
flujo2_final2 = 0;

flujo3_inicial1 = 0;
flujo3_inicial2 = 0;
flujo3_final1 = 0;
flujo3_final2 = 0;



cola1 = vnet.QueueCounter.ItemByKey(1);
cola2 = vnet.QueueCounter.ItemByKey(2);
cola3 = vnet.QueueCounter.ItemByKey(3);
cola4 = vnet.QueueCounter.ItemByKey(4);
cola5 = vnet.QueueCounter.ItemByKey(5);
cola6 = vnet.QueueCounter.ItemByKey(6);

contador1 = 0;
contador2 = 0;
contador3 = 0;

Tspan = 1000;
x10 = [12 12 12]; %tiempos iniciales para semaforos
sf1 = [25 38]; %valores de saturacion de las calles
sq1 = [50 100]; %valores de saturacion de las calles
qin1 = [0 0 0 0];
x1 = x10;

x20 = [12 12 12]; %tiempos iniciales para semaforos
sf2 = [25 38]; %valores de saturacion de las calles
sq2 = [50 100]; %valores de saturacion de las calles
qin2 = [0 0 0 0];
x2 = x20;

x30 = [12 12 12]; %tiempos iniciales para semaforos
sf3 = [25 38]; %valores de saturacion de las calles
sq3 = [50 100]; %valores de saturacion de las calles
qin3 = [0 0 0 0];
x3 = x30;



tiempo = 0;
aux1 = 1;
aux2 = 1;
aux3 = 1;

%% Simulacion principal
while tiempo<period_time
 sim.RunSingleStep;
 tiempo = sim.get('AttValue', 'SimSec');
 
%  if contador == 0   %Flujo de trafico al inicio de cada ciclo
%      flujo_inicial1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
%      flujo_inicial2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
%  end
 %s = [1400 1500]; %Saturacion de carretera medidos
 
 %INTERSECCION 1
 semaforo11 = round(x1(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo12 = round(x1(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)

 
 %INTERSECCION 2
 semaforo21 = round(x2(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo22 = round(x2(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
  
 %INTERSECCION 3
 semaforo31 = round(x3(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo32 = round(x3(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
  
 
 
 % ASIGNACION ESTADOS INTERSECCION 1 
     if contador1<=semaforo11   
         sg1_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg1_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
                  
     elseif (contador1>semaforo11)&&(contador1<=(semaforo11+semaforo12))
         sg1_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg1_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
        
     end
     
   % ASIGNACION ESTADOS INTERSECCION 2 
     if contador2<=semaforo21   
         sg2_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg2_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
        
     elseif (contador2>semaforo21)&&(contador2<=(semaforo21+semaforo22))
         sg2_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg2_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
                 
     end
     
     % ASIGNACION ESTADOS INTERSECCION 3
     if contador3<=semaforo31   
         sg3_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg3_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
        
     elseif (contador3>semaforo31)&&(contador3<=(semaforo31+semaforo32))
         sg3_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg3_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
                 
     end
     
    
     % INTERSECCION 1
     if contador1 == semaforo11+semaforo12 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador1=0;
         %INTERSECCION 1 
         %Flujos
         flujo1_final1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
         flujo1_final2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
         qin1 = double([flujo1_final1-flujo1_inicial1 flujo1_final2-flujo1_inicial2]);
         %Queue
         v1 = cola1.AttValue('QlenMax(Current,Current)');
         v2 = cola2.AttValue('QlenMax(Current,Current)');
        queue1 = [v1 v2];
        band1=isnan(queue1);
        for j=1:2
             if band1(j)==1
                 queue1(j)=1;
             end
        end %% Para evitar NaN
         
        
         
         [t1,x1] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x10,[],qin1,queue1,sf1,sq1,sum(x10));
         disp('Interseccion 1:');
         disp(x1(end,:));
         texto1 = sprintf('Suma %f',sum(x1(end,1:2)));
         disp(texto1)
         tiempo1(aux1,:)=x1(end,:);

         aux1=aux1+1;

         flujo1_inicial1 = flujo1_final1;
         flujo1_inicial2 = flujo1_final2;   
              
     end
     
     if contador2 == semaforo21+semaforo22 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador2=0;
          %INTERSECCION 2 
         %Flujos
         flujo2_final1 = vnet.DataCollectionMeasurement.ItemByKey(3).AttValue('Vehs(Current,Current,All)');
         flujo2_final2 = vnet.DataCollectionMeasurement.ItemByKey(4).AttValue('Vehs(Current,Current,All)');
         qin2 = double([flujo2_final1-flujo2_inicial1 flujo2_final2-flujo2_inicial2]);
         %Queue
         v3 = cola3.AttValue('QlenMax(Current,Current)');
         v4 = cola4.AttValue('QlenMax(Current,Current)');
         queue2 = [v3 v4];
         band2=isnan(queue2);
         for j=1:2
             if band2(j)==1
                 queue2(j)=1;
             end
         end %% Para evitar NaN
         
         [t2,x2] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x20,[],qin2,queue2,sf2,sq2,sum(x20));
         disp('Interseccion 2:');
         disp(x2(end,:));
         texto2 = sprintf('Suma %f',sum(x2(end,1:2)));
         disp(texto2)
         tiempo2(aux2,:)=x2(end,:);
         aux2=aux2+1;

         flujo2_inicial1 = flujo2_final1;
         flujo2_inicial2 = flujo2_final2;
         
     end
     
          if contador3 == semaforo31+semaforo32 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador3=0;
          %INTERSECCION 3 
         %Flujos
         flujo3_final1 = vnet.DataCollectionMeasurement.ItemByKey(5).AttValue('Vehs(Current,Current,All)');
         flujo3_final2 = vnet.DataCollectionMeasurement.ItemByKey(6).AttValue('Vehs(Current,Current,All)');
         qin3 = double([flujo3_final1-flujo3_inicial1 flujo3_final2-flujo3_inicial2]);
         %Queue
         v5 = cola5.AttValue('QlenMax(Current,Current)');
         v6 = cola6.AttValue('QlenMax(Current,Current)');
         queue3 = [v5 v6];
         band3=isnan(queue3);
         for j=1:2
             if band3(j)==1
                 queue3(j)=1;
             end
         end %% Para evitar NaN
         
         [t3,x3] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x30,[],qin3,queue3,sf3,sq3,sum(x30));
         disp('Interseccion 2:');
         disp(x3(end,:));
         texto2 = sprintf('Suma %f',sum(x2(end,1:2)));
         disp(texto2)
         tiempo3(aux3,:)=x3(end,:);
         aux3=aux3+1;

         flujo3_inicial1 = flujo3_final1;
         flujo3_inicial2 = flujo3_final2;
         
          end
    
    
     
    contador1 = contador1+1;   
    contador2 = contador2+1;
    contador3 = contador3+1;
        
      
    
end

save('Tiempos.mat','tiempo1','tiempo2','tiempo3');

%% Delete Vissim-COM server (also closes the Vissim GUI)
vis.release;
disp('The end')