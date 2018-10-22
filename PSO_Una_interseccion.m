close all
clear all
clc
vis=actxserver('VISSIM.vissim.100');
ruta_actual=pwd;
vis.LoadNet([ruta_actual '\test1.inpx']);
vis.LoadLayout([ruta_actual '\test1.layx']);
% iteraciones = 100;
% q1 = 1000; %flujo de entrada
% q2 = 1000; %Flujo de entrada
% q3 = 1000; %Flujo de entrada
% q4 = 1000;%Flujo de entrada
% tiempoCiclo=115;
% xmin = 0;
% xmax = tiempoCiclo;
% vmin = -50;
% vmax = 50;
% minimo_pers = [1000 1000 1000 1000]; %valores exageradamente grandes para comparar con los minimos resultantes
% minimo_global = 1000;
% 
% 
% %Poblacion Aleatoria
% poblacion = 4; %igual numero de semaforos
% x = zeros(poblacion,1); %tiempos en verde
% s = [100 150 100 150];
% while sum(x)~=tiempoCiclo
%     for i=1:poblacion
%        x(i,1) = round(xmin + (xmax-xmin)*rand());
% 
%     end
% end
% 
% for j=1:iteraciones
% v1 = 1;
% 
% v2 = 80;
% v3 = 20;
% 
% v4 = 60;
% 
% v5 = 50;
% v6 = 100;   
% y = [v1/s(1) (v2+v3)/s(2) v4/s(3) (v5+v6)/s(4)];
% miny = min(y);
% 
% for j=1:size(y,2) %se compara valores para encontrar el minimo
%              if y(j) < minimo_pers(j)
%                  minimo_pers(j) = y(j);
%              end
% end
% 
%          
% if miny < minimo_global
%     minimo_global = miny;
% end
% % actualizacion de posicion y velocidad
% c1 = 2;
% c2 = 0;
% v = zeros(poblacion,1);
% w = 1; %pesos
% rand1 = rand();
% rand2 = rand();   
%          
%  for h=1:poblacion
%                 v(h) = w*v(h)+c1*rand1*(minimo_pers(h)-x(h))+c2*rand2*(minimo_global-x(h)); %Actualizacion velocidad
%                 if v(h) > vmax %si se satura lo manda al valor maximo
%                     v(h) = vmax;
%                 elseif v(h) < vmin
%                     v(h) = vmin;                    
%                 end
%                 x(h) = x(h)+v(h);
%                 if x(h) > xmax %si se satura lo manda al valor maximo
%                     x(h) = xmax;
%                 elseif x(h)<xmin
%                     x(h) = xmin;
%                 end
% 
%  end
%          if sum(x) > tiempoCiclo
%             sobrante = sum(x)-tiempoCiclo;
%             for h=1:poblacion
%                 x(h) = x(h)- (sobrante/poblacion);
%             end
%          elseif sum(x) < tiempoCiclo
%              faltante = tiempoCiclo-sum(x);
%              for h=1:poblacion
%                 x(h) = x(h) + (faltante/poblacion);
%              end
%          end
%          disp(x');
%          disp('Suma')
%          disp(sum(x))
% end
% 
