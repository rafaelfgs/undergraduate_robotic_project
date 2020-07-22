function [Xd,dXd] = Controlar_Lemin(r1,r2,T,t)

Xd  = [r1*sin(2*pi/T*toc(t));r2*sin(4*pi/T*toc(t))];

dXd = [r1*2*pi/T*cos(2*pi/T*toc(t));r2*4*pi/T*cos(4*pi/T*toc(t))];