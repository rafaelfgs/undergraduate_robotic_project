function [Xd,dXd] = Controlar_Circ(r,T,t)

Xd  = [r*cos(2*pi/T*toc(t));r*sin(2*pi/T*toc(t))];

dXd = [-r*2*pi/T*sin(2*pi/T*toc(t));r*2*pi/T*cos(2*pi/T*toc(t))];