%% Vissim-COM programming - example code %%
clear all;
close all;
clc; % Clears the command window
%% Create Vissim-COM server
vis = actxserver('VISSIM.vissim.100');
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
%% PSO
xmin = 13;
xmax = 40;
vmin = -20;
vmax = 20;
minimo_pers = [1000 1000 1000 1000]; %valores exageradamente grandes para comparar con los minimos resultantes
minimo_global = 1000;
minx = minimo_pers;
ming = minimo_global;

%Poblacion Aleatoria
poblacion = 4;
c1 = 3;
c2 = 0.05;
v = zeros(poblacion,1);
w = 1; %pesos
x = [37 23 30 25];
s = [90 150 90 150];

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
 
disp('tiempos iniciales');
disp(x')
%% Simulacion principal
for i=0:((period_time*step_time)-2)
 sim.RunSingleStep;
 
 
%  if contador == 0   %Flujo de trafico al inicio de cada ciclo
%      flujo_inicial1 = vnet.DataCollectionMeasurement.ItemByKey(1).AttValue('Vehs(Current,Current,All)');
%      flujo_inicial2 = vnet.DataCollectionMeasurement.ItemByKey(2).AttValue('Vehs(Current,Current,All)');
%  end
 %s = [1400 1500]; %Saturacion de carretera medidos
 
 semaforo1 = x(1); %tiempo*step_time para verde semaforo 1 (sur-norte)
 semaforo2 = x(2); %tiempo*step_time para verde semaforo 2 (horizontal)
 semaforo3 = x(3); %tiempo*step_time para verde semaforo 3 (norte-sur)
 semaforo4 = x(4); %tiempo*step_time para verde semaforo 4 (horizontal)
 %semaforo1 = 0.8*tiempoCiclo*step_time; %tiempo*step_time para verde semaforo 1
 %semaforo2 = tiempoCiclo-semaforo1; %con esta resta se asegura el ciclo sea "tiempoCiclo"
 
     if contador<=semaforo1
        
         sg_1.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         
     elseif (contador>semaforo1)&&(contador<=(semaforo1+semaforo2))

         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
     elseif (contador > (semaforo1+semaforo2) )&&(contador <= (semaforo1+semaforo2+semaforo3) )

         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
     elseif (contador > (semaforo1+semaforo2+semaforo3) )&&(contador <=tiempoCiclo)

         sg_1.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_2.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_3.set('AttValue','State',1); % 1:rojo 2:amarillo 3:verde
         sg_4.set('AttValue','State',3); % 1:rojo 2:amarillo 3:verde
     end
     
     contador = contador+1;
     
     if contador == tiempoCiclo-1 % Si ya se cumple el ciclo, se mide flujos y se reinicia "contador"
         
         v1 = cola1.AttValue('QlenMax(Current,Current)');
         v2 = cola2.AttValue('QlenMax(Current,Current)');
         v3 = cola3.AttValue('QlenMax(Current,Current)');
         v4 = cola4.AttValue('QlenMax(Current,Current)');
         v5 = cola5.AttValue('QlenMax(Current,Current)');
         v6 = cola6.AttValue('QlenMax(Current,Current)');
         v7 = cola7.AttValue('QlenMax(Current,Current)');
         v8 = cola8.AttValue('QlenMax(Current,Current)');
         
         %evaluando poblacion
         if i>3*tiempoCiclo
             y = tiempoCiclo*[v1/s(1) (v2+v3+v7)/s(2) v4/s(3) (v5+v6+v8)/s(4)];
             [miny,indice] = min(y);
             for j=1:size(y,2) %se compara valores para encontrar el minimo
                 if y(j) < minimo_pers(j)
                     minimo_pers(j) = y(j);
                     minx(j)=x(j);
                 end
             end

             if miny < minimo_global
                 minimo_global = miny;
                 ming = x(indice);
             end
             
             
             % actualizacion de posicion y velocidad
   
             for h=1:poblacion
                    rand1 = rand();
                    rand2 = rand(); 
                    
                    %v(h) = w*v(h)+c1*rand1*(minimo_pers(h)-x(h))+c2*rand2*(minimo_global-x(h)); %Actualizacion velocidad
                    v(h) = w*v(h)+c1*rand1*(minx(h)-x(h))+c2*rand2*(ming-x(h)); %Actualizacion velocidad
                    if v(h) > vmax %si se satura lo manda al valor maximo
                        v(h) = vmax;
                    elseif v(h) < vmin
                        v(h) = vmin;                    
                    end
                    x(h) = x(h)+v(h);
                    if x(h) > xmax %si se satura lo manda al valor maximo
                        x(h) = xmax;
                    elseif x(h)<xmin
                        x(h) = xmin;
                    end

             end
             suma=sum(x);
             if suma<=xmin*4.2
 
                     minimo_pers = [1000 1000 1000 1000]; %Se resetea minimo personal
           
             end
             disp('estimacion velocidades:');
             disp(v')
             disp('estimacion tiempos:');
             disp(x)
             disp('suma inicial:');
             disp(suma)
             if sum(x) > tiempoCiclo
                sobrante = suma-tiempoCiclo;
                for h=1:poblacion
                    x(h) = x(h)- (x(h)/suma)*sobrante;
                end
             elseif suma < tiempoCiclo
                 faltante = tiempoCiclo-suma;
                 for h=1:poblacion
                    x(h) = x(h) + (x(h)/suma)*faltante;
                 end
             end
             disp('tiempos finales:')
             disp(x);
             disp('suma:');
             disp(sum(x));
             disp(' ');

         end
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