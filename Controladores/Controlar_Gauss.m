function [Ur,sat1] = Controlar_Gauss(Xtil,alfa,a)

sat1 = 0.25;
gain1 = 0.335;

sat2 = 0.1;
gain2 = 1;

cte = [sat1 gain1 sat2 gain2];

K = [ cos(alfa) -a*sin(alfa); sin(alfa) +a*cos(alfa) ];

F1 = sat1 .* tanh( gain1 * Xtil(1:2) );
F2 = sat2 .* exp( -gain2 * Xtil(1:2).^2 ) .* (Xtil(1:2));

Ur = K \ ( F1 + F2 );