function [Ur,sat] = Controlar_Reta(Xtil,dXd,alfa,a)

sat = 0.25;

cte = [sat 0 0 0];

K = [ cos(alfa) -a*sin(alfa); sin(alfa) +a*cos(alfa) ];

F = dXd + sat * Xtil(1:2);
        
Ur = K \ F;