function [Ur,sat] = Controlar_Tanh(Xtil,dXd,alfa,a)

sat = 0.4;
gain = 0.6;

cte = [sat gain 0 0];

K = [ cos(alfa) -a*sin(alfa); sin(alfa) +a*cos(alfa) ];

F = dXd + sat * tanh( gain * Xtil(1:2) );
        
Ur = K \ F;