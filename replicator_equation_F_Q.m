function dxdt = replicator_equation(t,x,flag,qin,queue,s_flujo,s_queue,tiempoCiclo)
%Ecuacion diferencial del replicador dinamico
%   Detailed explanation goes here
w1 = 0.8;
w2 = 0.2;
f1 = (w1*qin(1)+w2*queue(1))/((w1*s_flujo(1)+w2*s_queue(1))*x(1));
f2 = (w1*qin(2)+w2*queue(2))/((w1*s_flujo(2)+w2*s_queue(2))*x(2));
f3 = (w1*qin(3)+w2*queue(3))/((w1*s_flujo(3)+w2*s_queue(3))*x(3));
f4 = (w1*qin(4)+w2*queue(4))/((w1*s_flujo(4)+w2*s_queue(4))*x(4));
fbar = 1/tiempoCiclo*(f1*x(1)+f2*x(2)+f3*x(3)+f4*x(4));
dxdt(1,1) = x(1)*(f1-fbar);
dxdt(2,1) = x(2)*(f2-fbar);
dxdt(3,1) = x(3)*(f3-fbar);
dxdt(4,1) = x(4)*(f4-fbar);
end

