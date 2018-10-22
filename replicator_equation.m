function dxdt = replicator_equation(t,x,flag,qin,s,tiempoCiclo)
%Ecuacion diferencial del replicador dinamico
%   Detailed explanation goes here
f1 = qin(1)/(s(1)*x(1));
f2 = qin(2)/(s(2)*x(2));
f3 = qin(3)/(s(3)*x(3));
f4 = qin(4)/(s(4)*x(4));
fbar=1/tiempoCiclo*(f1*x(1)+f2*x(2)+f3*x(3)+f4*x(4));
dxdt(1,1) = x(1)*(f1-fbar);
dxdt(2,1) = x(2)*(f2-fbar);
dxdt(3,1) = x(3)*(f3-fbar);
dxdt(4,1) = x(4)*(f4-fbar);
end

