function [Ur,sat] = Controlar_Exp(Xtil,alfa,a)

sat = 0.25;
gain = 0.54;

cte = [sat gain 0 0];

K = [ cos(alfa) -a*sin(alfa); sin(alfa) +a*cos(alfa) ];

F1 = ( sat * ( eye(2) - diag(exp(-gain*abs(Xtil(1:2)))) ) ) * tanh(10*Xtil(1:2));

Ur = K \ F1;