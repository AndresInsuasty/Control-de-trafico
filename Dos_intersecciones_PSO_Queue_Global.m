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
minimo_pers = [1000 1000 1000 1000 1000 1000 1000 1000]; %valores exageradamente grandes para comparar con los minimos resultantes
minimo_global = 1000;
minx1 = minimo_pers;
ming1 = minimo_global;


%Poblacion Aleatoria
poblacion = 8;
x = [37 23 30 25 28 29 29 29];
s = [100 150 90 150 100 150 100 150];


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
disp(x(1:poblacion/2)')
disp('tiempos iniciales para 2');
disp(x(5:poblacion)')
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
 semaforo11 = x(1); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo12 = x(2); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo13 = x(3); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo14 = x(4); %tiempo*step_time para verde semaforo 4 (horizontal)
 
 % INTERSECCION 2
 semaforo21 = x(5); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo22 = x(6); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo23 = x(7); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo24 = x(8); %tiempo*step_time para verde semaforo 4 (horizontal)

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
         if i>4*tiempoCiclo
             
             % PSO INTERSECCION 
             y1 = tiempoCiclo*[v1/s(1) (v2+v3+v7)/s(2) v4/s(3) (v5+v6+v8)/s(4) v9/s(5) (v10+v11)/s(6) v12/s(7) v13/s(8)];
             [miny1,indice] = min(y1);
             for j=1:size(y1,2) %se compara valores para encontrar el minimo
                 if y1(j) < minimo_pers(j)
                     minimo_pers(j) = y1(j);
                     minx1(j)=x(j); % NO SE UTILIZA ESTA VARIABLE-depurar
                 end
             end

             if miny1 < minimo_global
                 minimo_global = miny1;
                 ming1 = x(indice);
             end
             % actualizacion de posicion y velocidad
             c1 = 5;
             c2 = 0.1;
             v = zeros(poblacion,1);
             w = 1; %pesos
             rand1 = rand();
             rand2 = rand();   

             for h=1:poblacion
                    v(h) = w*v(h)+c1*rand1*(minimo_pers(h)-x(h))+c2*rand2*(minimo_global-x(h)); %Actualizacion velocidad
                    if v(h) > vmax %si se satura lo manda al valor maximo
                        v(h) = vmax;
                    elseif v(h) < vmin
                        v(h) = vmin;                    
                    end
                    x(h) = x(h)+v(h)+rand();
                    if x(h) > xmax %si se satura lo manda al valor maximo
                        x(h) = xmax;
                    elseif x(h)<xmin
                        x(h) = xmin;
                    end

             end
             suma=sum(x(1:4));
             if suma==0
                 suma=1;
             end
             if suma > tiempoCiclo
                sobrante = suma-tiempoCiclo;
                for h=1:poblacion/2
                    x(h) = x(h)- (x(h)/suma)*sobrante;
                end
             elseif suma < tiempoCiclo
                 faltante = tiempoCiclo-suma;
                 for h=1:poblacion/2
                    x(h) = x(h) + (x(h)/suma)*faltante;
                 end
             end
             disp('tiempos finales 1:')
             disp(x(1:4)');
             
             suma=sum(x(5:poblacion));
             if suma==0
                 suma=1;
             end
             if suma > tiempoCiclo
                sobrante = suma-tiempoCiclo;
                for h=5:poblacion
                    x(h) = x(h)- (x(h)/suma)*sobrante;
                end
             elseif suma < tiempoCiclo
                 faltante = tiempoCiclo-suma;
                 for h=5:poblacion
                    x(h) = x(h) + (x(h)/suma)*faltante;
                 end
             end
             disp('tiempos finales 2:')
             disp(x(5:poblacion)');
             
             tiempo1(aux,:) = x;
             aux = aux+1;
             
             
         end
     end
     if contador == tiempoCiclo
        contador=0;
     end



      
     
 end
%% Delete Vissim-COM server (also closes the Vissim GUI)
csvwrite('TiempoSemaforosPSOGlobal.dat',tiempo1);
vis.release;
disp('The end')