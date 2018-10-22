function dxdt = replicator_equation(t,x,flag,qin,queue,s_flujo,s_queue,sumatiempo)
%Ecuacion diferencial del replicador dinamico
%   Detailed explanation goes here
w1 = 0.9;
w2 = 0.1;
min = 1;
ep = 0.0000001;
% f1 = (w1*qin(1)+w2*queue(1))/((w1*s_flujo(1)+w2*s_queue(1))*x(1))*1*ep/(min-x(1));
% f2 = (w1*qin(2)+w2*queue(2))/((w1*s_flujo(2)+w2*s_queue(2))*x(2)*1*ep/(min-x(2)));
% f3 = (w1*mean(qin)+w2*mean(queue))/((w1*mean(s_flujo)+w2*mean(s_queue))*x(3))*1*ep/(min-x(3));
f1 = (w1*qin(1)+w2*queue(1))/((w1*s_flujo(1)+w2*s_queue(1))*x(1));
f2 = (w1*qin(2)+w2*queue(2))/((w1*s_flujo(2)+w2*s_queue(2))*x(2));
f3 = (w1*mean(qin)+w2*mean(queue))/((w1*mean(s_flujo)+w2*mean(s_queue))*x(3));
fbar = (1/sumatiempo)*(f1*x(1)+f2*x(2)+f3*x(3));
dxdt(1,1) = x(1)*(f1-fbar);
dxdt(2,1) = x(2)*(f2-fbar);
dxdt(3,1) = x(3)*(f3-fbar);

end

