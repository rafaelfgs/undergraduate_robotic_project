function [Ur,sat1] = Controlar_InvX(Xtil,alfa,a)

sat1 = 0.25;
gain1 = 0.31;

sat2 = 0.05;
gain2 = 4;

cte = [sat1 gain1 sat2 gain2];

K = [ cos(alfa) -a*sin(alfa); sin(alfa) +a*cos(alfa) ];

F1 = sat1 * tanh( gain1 * Xtil(1:2) );

F2 = sat2 ./ ( 1 + abs(Xtil(1:2)) ) .* tanh( gain2 * Xtil(1:2) );

Ur = K \ ( F1 + F2 );