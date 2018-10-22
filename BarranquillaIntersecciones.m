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
vis.LoadNet([ruta_actual '\RedBarranquilla.inpx']);
vis.LoadLayout([ruta_actual '\RedBarranquilla.layx']);
%% Definir la red como objeto
vnet = vis.Net;
%% Configurando demanda de trafico
flujo=1000;
q1 = 2400; %flujo de entrada
q2 = flujo/2; %Flujo de entrada
q3 = flujo/2; %Flujo de entrada
q4 = flujo;%Flujo de entrada
q5 = 2400;
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
period_time = 18000;
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

sc4 = scs.ItemByKey(4);
sgs4 = sc4.SGs;
sg4_1 = sgs4.ItemByKey(1);
sg4_2 = sgs4.ItemByKey(2);

sc5 = scs.ItemByKey(5);
sgs5 = sc5.SGs;
sg5_1 = sgs5.ItemByKey(1);
sg5_2 = sgs5.ItemByKey(2);

sc6 = scs.ItemByKey(6);
sgs6 = sc6.SGs;
sg6_1 = sgs6.ItemByKey(1);
sg6_2 = sgs6.ItemByKey(2);

sc7 = scs.ItemByKey(7);
sgs7 = sc7.SGs;
sg7_1 = sgs7.ItemByKey(1);
sg7_2 = sgs7.ItemByKey(2);

sc8 = scs.ItemByKey(8);
sgs8 = sc8.SGs;
sg8_1 = sgs8.ItemByKey(1);
sg8_2 = sgs8.ItemByKey(2);
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

flujo4_inicial1 = 0;
flujo4_inicial2 = 0;
flujo4_final1 = 0;
flujo4_final2 = 0;

flujo5_inicial1 = 0;
flujo5_inicial2 = 0;
flujo5_final1 = 0;
flujo5_final2 = 0;

flujo6_inicial1 = 0;
flujo6_inicial2 = 0;
flujo6_final1 = 0;
flujo6_final2 = 0;

flujo7_inicial1 = 0;
flujo7_inicial2 = 0;
flujo7_final1 = 0;
flujo7_final2 = 0;

flujo8_inicial1 = 0;
flujo8_inicial2 = 0;
flujo8_final1 = 0;
flujo8_final2 = 0;

cola1 = vnet.QueueCounter.ItemByKey(1);
cola2 = vnet.QueueCounter.ItemByKey(2);
cola3 = vnet.QueueCounter.ItemByKey(3);
cola4 = vnet.QueueCounter.ItemByKey(4);
cola5 = vnet.QueueCounter.ItemByKey(5);
cola6 = vnet.QueueCounter.ItemByKey(6);
cola7 = vnet.QueueCounter.ItemByKey(7);
cola8 = vnet.QueueCounter.ItemByKey(8);
cola9 = vnet.QueueCounter.ItemByKey(9);
cola10 = vnet.QueueCounter.ItemByKey(10);
cola11 = vnet.QueueCounter.ItemByKey(11);
cola12 = vnet.QueueCounter.ItemByKey(12);
cola13 = vnet.QueueCounter.ItemByKey(13);
cola14 = vnet.QueueCounter.ItemByKey(14);
cola15 = vnet.QueueCounter.ItemByKey(15);
cola16 = vnet.QueueCounter.ItemByKey(16);

contador1 = 0;
contador2 = 0;
contador3 = 0;
contador4 = 0;
contador5 = 0;
contador6 = 0;
contador7 = 0;
contador8 = 0;

Tspan = 1000;
x10 = [12 12 12]; %tiempos iniciales para semaforos
sf1 = [46 38]; %valores de saturacion de las calles
sq1 = [100 100]; %valores de saturacion de las calles
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

x40 = [12 12 12]; %tiempos iniciales para semaforos
sf4 = [25 38]; %valores de saturacion de las calles
sq4 = [50 100]; %valores de saturacion de las calles
qin4 = [0 0 0 0];
x4 = x40;

x50 = [12 12 12]; %tiempos iniciales para semaforos
sf5 = [50 38]; %valores de saturacion de las calles
sq5 = [100 100]; %valores de saturacion de las calles
qin5 = [0 0 0 0];
x5 = x50;

x60 = [12 12 12]; %tiempos iniciales para semaforos
sf6 = [25 38]; %valores de saturacion de las calles
sq6 = [50 100]; %valores de saturacion de las calles
qin6 = [0 0 0 0];
x6 = x60;

x70 = [12 12 12]; %tiempos iniciales para semaforos
sf7 = [25 38]; %valores de saturacion de las calles
sq7 = [50 100]; %valores de saturacion de las calles
qin7 = [0 0 0 0];
x7 = x70;

x80 = [12 12 12]; %tiempos iniciales para semaforos
sf8 = [25 40]; %valores de saturacion de las calles
sq8 = [50 100]; %valores de saturacion de las calles
qin8 = [0 0 0 0];
x8 = x80;

tiempo = 0;
aux1 = 1;
aux2 = 1;
aux3 = 1;
aux4 = 1;
aux5 = 1;
aux6 = 1;
aux7 = 1;
aux8 = 1;
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
  
 %INTERSECCION 4
 semaforo41 = round(x4(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo42 = round(x4(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
  
 %INTERSECCION 5
 semaforo51 = round(x5(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo52 = round(x5(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
  
 %INTERSECCION 6
 semaforo61 = round(x6(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo62 = round(x6(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
  
 %INTERSECCION 7
 semaforo71 = round(x7(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo72 = round(x7(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
  
 %INTERSECCION 8
 semaforo81 = round(x8(end,1)); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo82 = round(x8(end,2)); %tiempo*step_time para verde semaforo 2 (horizontal)
 

 
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
     
     % ASIGNACION ESTADOS INTERSECCION 4
     if contador4<=semaforo41   
         sg4_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg4_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
        
     elseif (contador4>semaforo41)&&(contador4<=(semaforo41+semaforo42))
         sg4_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg4_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
                 
     end
     
     % ASIGNACION ESTADOS INTERSECCION 5
     if contador5<=semaforo51   
         sg5_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg5_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
        
     elseif (contador5>semaforo51)&&(contador5<=(semaforo51+semaforo52))
         sg5_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg5_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
                 
     end
     
     % ASIGNACION ESTADOS INTERSECCION 6
     if contador6<=semaforo61   
         sg6_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg6_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
        
     elseif (contador6>semaforo61)&&(contador6<=(semaforo61+semaforo62))
         sg6_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg6_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
                 
     end
     
     % ASIGNACION ESTADOS INTERSECCION 7
     if contador7<=semaforo71   
         sg7_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg7_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
        
     elseif (contador7>semaforo71)&&(contador7<=(semaforo71+semaforo72))
         sg7_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg7_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
                 
     end
     
     % ASIGNACION ESTADOS INTERSECCION 8
     if contador8<=semaforo81   
         sg8_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg8_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
        
     elseif (contador8>semaforo81)&&(contador8<=(semaforo81+semaforo82))
         sg8_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg8_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
                 
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
%          disp('Interseccion 1:');
%          disp(x1(end,:));
%          texto1 = sprintf('Suma %f',sum(x1(end,1:4)));
%          disp(texto1)
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
%          disp('Interseccion 2:');
%          disp(x2(end,:));
%          texto2 = sprintf('Suma %f',sum(x2(end,1:4)));
%          disp(texto2)
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
%          disp('Interseccion 2:');
%          disp(x2(end,:));
%          texto2 = sprintf('Suma %f',sum(x2(end,1:4)));
%          disp(texto2)
         tiempo3(aux3,:)=x3(end,:);
         aux3=aux3+1;

         flujo3_inicial1 = flujo3_final1;
         flujo3_inicial2 = flujo3_final2;
         
          end
     
     if contador4 == semaforo41+semaforo42 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador4=0;
          %INTERSECCION 4 
         %Flujos
         flujo4_final1 = vnet.DataCollectionMeasurement.ItemByKey(7).AttValue('Vehs(Current,Current,All)');
         flujo4_final2 = vnet.DataCollectionMeasurement.ItemByKey(8).AttValue('Vehs(Current,Current,All)');
         qin4 = double([flujo4_final1-flujo4_inicial1 flujo4_final2-flujo4_inicial2]);
         %Queue
         v7 = cola7.AttValue('QlenMax(Current,Current)');
         v8 = cola8.AttValue('QlenMax(Current,Current)');
         queue4 = [v7 v8];
         band4=isnan(queue4);
         for j=1:2
             if band4(j)==1
                 queue4(j)=1;
             end
         end %% Para evitar NaN
         
         [t4,x4] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x40,[],qin4,queue4,sf4,sq4,sum(x40));
%          disp('Interseccion 2:');
%          disp(x2(end,:));
%          texto2 = sprintf('Suma %f',sum(x2(end,1:4)));
%          disp(texto2)
         tiempo4(aux4,:)=x4(end,:);
         aux4=aux4+1;

         flujo4_inicial1 = flujo4_final1;
         flujo4_inicial2 = flujo4_final2;
         
     end
      
     if contador5 == semaforo51+semaforo52 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador5=0;
          %INTERSECCION 5 
         %Flujos
         flujo5_final1 = vnet.DataCollectionMeasurement.ItemByKey(9).AttValue('Vehs(Current,Current,All)');
         flujo5_final2 = vnet.DataCollectionMeasurement.ItemByKey(10).AttValue('Vehs(Current,Current,All)');
         qin5 = double([flujo5_final1-flujo5_inicial1 flujo5_final2-flujo5_inicial2]);
         %Queue
         v9 = cola9.AttValue('QlenMax(Current,Current)');
         v10 = cola10.AttValue('QlenMax(Current,Current)');
         queue5 = [v9 v10];
         band5=isnan(queue5);
         for j=1:2
             if band5(j)==1
                 queue5(j)=1;
             end
         end %% Para evitar NaN
         
         [t5,x5] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x50,[],qin5,queue5,sf5,sq5,sum(x50));
%          disp('Interseccion 2:');
%          disp(x2(end,:));
%          texto2 = sprintf('Suma %f',sum(x2(end,1:4)));
%          disp(texto2)
         tiempo5(aux5,:)=x5(end,:);
         aux5=aux5+1;

         flujo5_inicial1 = flujo5_final1;
         flujo5_inicial2 = flujo5_final2;
         
     end
      
     if contador6 == semaforo61+semaforo62 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador6=0;
          %INTERSECCION 6 
         %Flujos
         flujo6_final1 = vnet.DataCollectionMeasurement.ItemByKey(11).AttValue('Vehs(Current,Current,All)');
         flujo6_final2 = vnet.DataCollectionMeasurement.ItemByKey(12).AttValue('Vehs(Current,Current,All)');
         qin6 = double([flujo6_final1-flujo6_inicial1 flujo6_final2-flujo6_inicial2]);
         %Queue
         v11 = cola11.AttValue('QlenMax(Current,Current)');
         v12 = cola12.AttValue('QlenMax(Current,Current)');
         queue6 = [v11 v12];
         band6=isnan(queue6);
         for j=1:2
             if band6(j)==1
                 queue6(j)=1;
             end
         end %% Para evitar NaN
         
         [t6,x6] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x60,[],qin6,queue6,sf6,sq6,sum(x60));
%          disp('Interseccion 2:');
%          disp(x2(end,:));
%          texto2 = sprintf('Suma %f',sum(x2(end,1:4)));
%          disp(texto2)
         tiempo6(aux6,:)=x6(end,:);
         aux6=aux6+1;

         flujo6_inicial1 = flujo6_final1;
         flujo6_inicial2 = flujo6_final2;
         
     end
      
     if contador7 == semaforo71+semaforo72 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador7=0;
          %INTERSECCION 7 
         %Flujos
         flujo7_final1 = vnet.DataCollectionMeasurement.ItemByKey(13).AttValue('Vehs(Current,Current,All)');
         flujo7_final2 = vnet.DataCollectionMeasurement.ItemByKey(14).AttValue('Vehs(Current,Current,All)');
         qin7 = double([flujo7_final1-flujo7_inicial1 flujo7_final2-flujo7_inicial2]);
         %Queue
         v13 = cola13.AttValue('QlenMax(Current,Current)');
         v14 = cola14.AttValue('QlenMax(Current,Current)');
         queue7 = [v13 v14];
         band7 = isnan(queue7);
         for j=1:2
             if band7(j)==1
                 queue7(j)=1;
             end
         end %% Para evitar NaN
         
         [t7,x7] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x70,[],qin7,queue7,sf7,sq7,sum(x70));
%          disp('Interseccion 2:');
%          disp(x2(end,:));
%          texto2 = sprintf('Suma %f',sum(x2(end,1:4)));
%          disp(texto2)
         tiempo7(aux7,:)=x7(end,:);
         aux7=aux7+1;

         flujo7_inicial1 = flujo7_final1;
         flujo7_inicial2 = flujo7_final2;
         
     end
     
     if contador8 == semaforo81+semaforo82 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         contador8=0;
          %INTERSECCION 8 
         %Flujos
         flujo8_final1 = vnet.DataCollectionMeasurement.ItemByKey(15).AttValue('Vehs(Current,Current,All)');
         flujo8_final2 = vnet.DataCollectionMeasurement.ItemByKey(16).AttValue('Vehs(Current,Current,All)');
         qin8 = double([flujo8_final1-flujo8_inicial1 flujo8_final2-flujo8_inicial2]);
         %Queue
         v15 = cola15.AttValue('QlenMax(Current,Current)');
         v16 = cola16.AttValue('QlenMax(Current,Current)');
         queue8 = [v15 v16];
         band8 = isnan(queue8);
         for j=1:2
             if band8(j)==1
                 queue8(j)=1;
             end
         end %% Para evitar NaN
         
         [t8,x8] = ode23s('replicator_equation_F_Q_tiempo_variable_Barranquilla',Tspan,x80,[],qin8,queue8,sf8,sq8,sum(x80));
%          disp('Interseccion 2:');
%          disp(x2(end,:));
%          texto2 = sprintf('Suma %f',sum(x2(end,1:4)));
%          disp(texto2)
         tiempo8(aux8,:)=x8(end,:);
         aux8=aux8+1;

         flujo8_inicial1 = flujo8_final1;
         flujo8_inicial2 = flujo8_final2;
         
     end
     
    contador1 = contador1+1;   
    contador2 = contador2+1;
    contador3 = contador3+1;
    contador4 = contador4+1;
    contador5 = contador5+1;
    contador6 = contador6+1;
    contador7 = contador7+1;
    contador8 = contador8+1;
    
    %% para cambiar flujos de trafico durante la simulación
  switch tiempo
      case 1200
        flujo=2400;
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
        
      case 2400
        flujo=1000;
        q1 = 2400; %flujo de entrada
        q2 = flujo/2; %Flujo de entrada
        q3 = flujo/2; %Flujo de entrada
        q4 = flujo;%Flujo de entrada
        q5 = 2400;
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
  end
    
    
end

%% Delete Vissim-COM server (also closes the Vissim GUI)
vis.release;
disp('The end')