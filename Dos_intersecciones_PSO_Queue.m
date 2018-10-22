%% Vissim-COM programming - example code %%
clear all;
close all;
clc; % Clear the command window
%% Create Vissim-COM server
vis = actxserver('VISSIM.vissim.100');
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
q1 = 1000; %flujo de entrada
q2 = 1000; %Flujo de entrada
q3 = 1000; %Flujo de entrada
q4 = 400;%Flujo de entrada
q5 = 1000;
q6 = 900;
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
sc = scs.ItemByKey(1);
sgs1 = sc.SGs; %SGs=SigalGroups
sg_1 = sgs1.ItemByKey(1);
sg_2 = sgs1.ItemByKey(2);
sg_3 = sgs1.ItemByKey(3);
sg_4 = sgs1.ItemByKey(4);

sc2 = scs.ItemByKey(2);
sgs2 = sc2.SGs;
sg2_1 = sgs2.ItemByKey(1);
sg2_2 = sgs2.ItemByKey(2);
sg2_3 = sgs2.ItemByKey(3);
sg2_4 = sgs2.ItemByKey(4);

%% Inicializacion de parametros
tiempoCiclo=115*step_time; %tiempo de rojo+verde de la fase de los semaforos, tiempo*step_time

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
%% PSO
xmin = 9;
xmax = tiempoCiclo;
vmin = -50;
vmax = 50;

% INTERSECCION 1
minimo_pers1 = [1000 1000 1000 1000]; %valores exageradamente grandes para comparar con los minimos resultantes
minimo_global1 = 1000;
minx1 = minimo_pers1;
ming1 = minimo_global1;

% INTERSECCION 2
minimo_pers2 = [1000 1000 1000 1000]; %valores exageradamente grandes para comparar con los minimos resultantes
minimo_global2 = 1000;
minx2 = minimo_pers2;
ming2 = minimo_global2;

%Poblacion Aleatoria
poblacion1 = 4;
x1 = [37 23 30 25];
s1 = [100 150 90 150];

%Poblacion Aleatoria
poblacion2 = 4;
x2 = [37 23 30 25];
s2 = [100 150 100 150];

ve1 = zeros(poblacion1,1);
ve2 = zeros(poblacion2,1);

% while sum(x)~=tiempoCiclo
%     for i=1:poblacion
%        x(i,1) = round(xmin + (xmax-xmin)*rand());
% 
%     end
% end

contador=0;
% for i=1:115((period_time*step_time)-2)
%  sim.RunSingleStep;
%  
% end
 
disp('tiempos iniciales para 1');
disp(x1')
disp('tiempos iniciales para 2');
disp(x2')
aux=1;
%% Simulacion principal
for i=0:((period_time*step_time)-2)
 sim.RunSingleStep;
 
 
%  if contador == 0   %Flujo de trafico al inicio de cada ciclo
%      flujo_inicial1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
%      flujo_inicial2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
%  end
 %s = [1400 1500]; %Saturacion de carretera medidos
 
 % INTERESECCION 1
 semaforo11 = x1(1); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo12 = x1(2); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo13 = x1(3); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo14 = x1(4); %tiempo*step_time para verde semaforo 4 (horizontal)
 
 % INTERSECCION 2
 semaforo21 = x2(1); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo22 = x2(2); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo23 = x2(3); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo24 = x2(4); %tiempo*step_time para verde semaforo 4 (horizontal)

 % ASIGNACION ESTADOS INTERSECCION 1 
     if contador<=semaforo11
        
         sg_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador>semaforo11)&&(contador<=(semaforo11+semaforo12))

         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
     elseif (contador > (semaforo11+semaforo12) )&&(contador <= (semaforo11+semaforo12+semaforo13) )

         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
     elseif (contador > (semaforo11+semaforo12+semaforo13) )&&(contador <=tiempoCiclo)

         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
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
     
     if contador == tiempoCiclo-1 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         
         
         % INTERSECCION 1
         v1 = cola1.AttValue('QlenMax(Current,Current)');
         v2 = cola2.AttValue('QlenMax(Current,Current)');
         v3 = cola3.AttValue('QlenMax(Current,Current)');
         v4 = cola4.AttValue('QlenMax(Current,Current)');
         v5 = cola5.AttValue('QlenMax(Current,Current)');
         v6 = cola6.AttValue('QlenMax(Current,Current)');
         v7 = cola7.AttValue('QlenMax(Current,Current)');
         v8 = cola8.AttValue('QlenMax(Current,Current)');
         
                      
         % INTERSECCION 2             
         v9 = cola9.AttValue('Qlen(Current,Current)');
         v10 = cola10.AttValue('Qlen(Current,Current)');
         v11 = cola11.AttValue('Qlen(Current,Current)');
         v12 = cola12.AttValue('Qlen(Current,Current)');
         v13 = cola13.AttValue('Qlen(Current,Current)');
         
         %evaluando poblacion
         if i>3*tiempoCiclo
             
             % PSO INTERSECCION 1
             y1 = tiempoCiclo*[v1/s1(1) (v2+v3+v7)/s1(2) v4/s1(3) (v5+v6+v8)/s1(4)];
             [miny1,indice] = min(y1);
             for j=1:size(y1,2) %se compara valores para encontrar el minimo
                 if y1(j) < minimo_pers1(j)
                     minimo_pers1(j) = y1(j);
                     minx1(j)=x1(j); % NO SE UTILIZA ESTA VARIABLE-depurar
                 end
             end

             if miny1 < minimo_global1
                 minimo_global1 = miny1;
                 ming1 = x1(indice);
             end
             % actualizacion de posicion y velocidad
             c1 = 5;
             c2 = 0.05;
             w = 1; %pesos
             rand1 = rand();
             rand2 = rand();   

             for h=1:poblacion1
                    ve1(h) = w*ve1(h)+c1*rand1*(minimo_pers1(h)-x1(h))+c2*rand2*(minimo_global1-x1(h)); %Actualizacion velocidad
                    if ve1(h) > vmax %si se satura lo manda al valor maximo
                        ve1(h) = vmax;
                    elseif ve1(h) < vmin
                        ve1(h) = vmin;                    
                    end
                    x1(h) = x1(h)+ve1(h)+rand();
                    if x1(h) > xmax %si se satura lo manda al valor maximo
                        x1(h) = xmax;
                    elseif x1(h)<xmin
                        x1(h) = xmin;
                    end

             end
             suma=sum(x1);
             if suma==0
                 suma=1;
             end
             if sum(x1) > tiempoCiclo
                sobrante = suma-tiempoCiclo;
                for h=1:poblacion1
                    x1(h) = x1(h)- (x1(h)/suma)*sobrante;
                end
             elseif suma < tiempoCiclo
                 faltante = tiempoCiclo-suma;
                 for h=1:poblacion1
                    x1(h) = x1(h) + (x1(h)/suma)*faltante;
                 end
             end
             disp('tiempos finales 1:')
             disp(x1');
             tiempo1(aux,:) = x1;
             
             % PSO INTERSECCION 2
             y2 = tiempoCiclo*[v9/s2(1) (v10+v11)/s2(2) v12/s2(3) v13/s2(4)];
             [miny2,indice] = min(y2);
             for j=1:size(y2,2) %se compara valores para encontrar el minimo
                 if y2(j) < minimo_pers2(j)
                     minimo_pers2(j) = y2(j);
                     minx2(j)=x2(j);
                 end
             end

             if miny2 < minimo_global2
                 minimo_global2 = miny2;
                 ming2 = x2(indice);
             end
             % actualizacion de posicion y velocidad
             c1 = 5;
             c2 = 0.05;
             w = 1; %pesos
             rand1 = rand();
             rand2 = rand();   

             for h=1:poblacion1
                    ve2(h) = w*ve2(h)+c1*rand1*(minimo_pers2(h)-x2(h))+c2*rand2*(minimo_global2-x2(h)); %Actualizacion velocidad
                    if ve2(h) > vmax %si se satura lo manda al valor maximo
                        ve2(h) = vmax;
                    elseif ve2(h) < vmin
                        ve2(h) = vmin;                    
                    end
                    x2(h) = x2(h)+ve2(h)+rand();
                    if x2(h) > xmax %si se satura lo manda al valor maximo
                        x2(h) = xmax;
                    elseif x2(h)<xmin
                        x2(h) = xmin;
                    end
             end
             suma=sum(x2);
             if suma==0
                 suma=1;
             end
             if suma > tiempoCiclo
                sobrante = suma-tiempoCiclo;
                for h=1:poblacion1
                    x2(h) = x2(h)- (x2(h)/suma)*sobrante;
                end
             elseif suma < tiempoCiclo
                 faltante = tiempoCiclo-suma;
                 for h=1:poblacion1
                    x2(h) = x2(h) + (x2(h)/suma)*faltante;
                 end
             end
             disp('tiempos finales 2:')
             disp(x2');
             disp(' ');
             tiempo2(aux,:) = x2;
             aux = aux+1;

         end
     end
     if contador == tiempoCiclo
        contador=0;
     end



      
     
 end
%% Delete Vissim-COM server (also closes the Vissim GUI)
tiempo = [tiempo1 tiempo2];
csvwrite('TiempoSemaforosPSO.dat',tiempo);
vis.release;
disp('The end')