
void TransInverse(){

    float xf, yf, zf, ph, th, ps, p, q, b;
    float r, h1, h2, h3, a1, a2;
    
xf = FormAct[0];
yf = FormAct[1];
zf = FormAct[2];
ph = FormAct[3];
th = FormAct[4];
ps = FormAct[5];
p  = FormAct[6];
q  = FormAct[7];
b  = FormAct[8];

r  = sqrt(p*p+q*q-2*p*q*cos(b));
h1 = sqrt((1/2)*(p*p+q*q-(1/2)*r*r));
h2 = sqrt((1/2)*(r*r+p*p-(1/2)*q*q));
h3 = sqrt((1/2)*(q*q+r*r-(1/2)*p*p));
a1 = acos((4*(h1*h1+h2*h2)-9*p*p)/(8*h1*h2));
a2 = acos((4*(h1*h1+h3*h3)-9*q*q)/(8*h1*h3));


// Matriz de Rotacao
// Pegar Matriz de Rotacao
/*
RotX = [1 0 0; 0 cos(ph) -sin(ph); 0 sin(ph) cos(ph)];
RotY = [cos(th) 0 sin(th); 0 1 0; -sin(th) 0 cos(th)];
RotZ = [cos(ps) -sin(ps) 0; sin(ps) cos(ps) 0; 0 0 1];

Rot = RotZ*RotY*RotX;
*/

// Anti-horária: ABC -> z > 0
// Posição desejada dos robôs

// Fazer alterações para efetuar produto matricial
posRobos = [Rot*[2/3*h1; 0; 0] + [xf;yf;zf];
        Rot*[2/3*h2*cos(a1);  2/3*h2*sin(a1); 0] + [xf;yf;zf];
        Rot*[2/3*h3*cos(a2); -2/3*h3*sin(a2); 0] + [xf;yf;zf]];
    
    
}