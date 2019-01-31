clear all
close all
clc
%%
load('Tiempos1.mat')
tiempo1=round(tiempo1);
tiempo2=round(tiempo2);
tiempo3=round(tiempo3);
acu=[24 24 24];
aux=1;
size=15;
for i=1:440
    a = acu(1)+tiempo1(i,1);
    plot(acu(1):a,1,'g.','MarkerSize',size);
    hold on
    line([acu(1) acu(1)], [1 2],'LineStyle',':'); 
    hold on
    plot(a:(a + tiempo1(i,2) ),1,'r.','MarkerSize',size);
    hold on
    
    
    b = acu(2)+tiempo2(i,1);
    plot(acu(2):b,2,'g.','MarkerSize',size);
    hold on
    line([acu(2) acu(2)], [2 3],'LineStyle',':'); 
    hold on
    plot(b:(b + tiempo2(i,2) ),2,'r.','MarkerSize',size);
    hold on
    
    c = acu(3)+tiempo3(i,1);
    plot(acu(3):c,3,'g.','MarkerSize',size);
    hold on
    plot(c:(c + tiempo3(i,2) ),3,'r.','MarkerSize',size);

    
%     aux=aux+1;
%     if aux==3
%         hold off
%         aux=1;
%     else
%         hold on
%     end
    acu(1) = acu(1)+tiempo1(1,1)+tiempo1(1,2);
    acu(2) = acu(2)+tiempo2(1,1)+tiempo2(1,2);
    acu(3) = acu(3)+tiempo3(1,1)+tiempo3(1,2);
    
%     hold off
    ylim([0.5 3.5]);
    xlabel('Tiempo [s]');
    ylabel('Semaforo');

ciclo1 = tiempo1(:,1)+tiempo1(:,2);
ciclo2 = tiempo2(:,1)+tiempo2(:,2);
ciclo3 = tiempo3(:,1)+tiempo3(:,2);
promedio1 = mean(ciclo1);
promedio2 = mean(ciclo2);
promedio3 = mean(ciclo3);
 
end

