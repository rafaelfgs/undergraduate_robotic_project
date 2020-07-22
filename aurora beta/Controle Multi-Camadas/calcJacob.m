clear all;
close all;
clc;

%Jacobiano

syms xf yf zf ph th ps p q b real

r  = sqrt(p^2+q^2-2*p*q*cos(b));
h1 = sqrt((1/2)*(p^2+q^2-(1/2)*r^2));
h2 = sqrt((1/2)*(r^2+p^2-(1/2)*q^2));
h3 = sqrt((1/2)*(q^2+r^2-(1/2)*p^2));
a1 = acos((4*(h1^2+h2^2)-9*p^2)/(8*h1*h2));
a2 = acos((4*(h1^2+h3^2)-9*q^2)/(8*h1*h3));

%%% Matriz de Rotacao
RotX = [1 0 0; 0 cos(ph) -sin(ph); 0 sin(ph) cos(ph)];
RotY = [cos(th) 0 sin(th); 0 1 0; -sin(th) 0 cos(th)];
RotZ = [cos(ps) -sin(ps) 0; sin(ps) cos(ps) 0; 0 0 1];

Rot = RotZ*RotY*RotX;

% Anti-horária: ABC -> z > 0
% Posição desejada dos robôs
posRobos = [Rot*[2/3*h1; 0; 0] + [xf;yf;zf];
    Rot*[2/3*h2*cos(a1);  2/3*h2*sin(a1); 0] + [xf;yf;zf];
    Rot*[2/3*h3*cos(a2); -2/3*h3*sin(a2); 0] + [xf;yf;zf]];
 
JacobianoInversoABC = simplify(jacobian(posRobos,[xf yf zf ph th ps p q b]'));

% Anti-horária: ACB -> z < 0
% Posição desejada dos robôs
posRobos = [Rot*[2/3*h1; 0; 0] + [xf;yf;zf];
    Rot*[2/3*h2*cos(a1); -2/3*h2*sin(a1); 0] + [xf;yf;zf];
    Rot*[2/3*h3*cos(a2);  2/3*h3*sin(a2); 0] + [xf;yf;zf]];
 
JacobianoInversoACB = simplify(jacobian(posRobos,[xf yf zf ph th ps p q b]'));

% 
% 
% 
% JacobianoInversoACB = simplify(jacobian([formxf + (2/3)*hF*cos(formfi), ...
%     formyf + (2/3)*hF*sin(formfi), ...
%     formxf + (2/3)*hF*cos(formfi) - formp*cos(formfi + alpha), ...
%     formyf + (2/3)*hF*sin(formfi) - formp*sin(formfi + alpha), ...
%     formxf + (2/3)*hF*cos(formfi) - formq*cos(formfi + alpha - formbeta), ...
%     formyf + (2/3)*hF*sin(formfi) - formq*sin(formfi + alpha - formbeta)], ...
%     [formxf; formyf; formfi; formp; formq; formbeta]));
% 



