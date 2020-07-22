function mTransformacaoInversa(Formacao,cOUd)

if strcmp(cOUd,'c')
    posFormacao = Formacao.pPos.q;
elseif strcmp(cOUd,'d')
    posFormacao = Formacao.pPos.qd;
else
    disp('cOUd deve ser ''c'' para valores correntes ou ''d'' para valores desejados')
end

xf = posFormacao(1);
yf = posFormacao(2);
zf = posFormacao(3);
ph = posFormacao(4);
th = posFormacao(5);
ps = posFormacao(6);
p  = posFormacao(7);
q  = posFormacao(8);
b  = posFormacao(9);

r  = sqrt(p^2+q^2-2*p*q*cos(b));
h1 = sqrt((1/2)*(p^2+q^2-(1/2)*r^2));
h2 = sqrt((1/2)*(r^2+p^2-(1/2)*q^2));
h3 = sqrt((1/2)*(q^2+r^2-(1/2)*p^2));
a1 = acos((4*(h1^2+h2^2)-9*p^2)/(8*h1*h2));
a2 = acos((4*(h1^2+h3^2)-9*q^2)/(8*h1*h3));

if isnan(a1)
    a1 = 0;
end

if isnan(a2)
    a2 = 0;
end

%%% Matriz de Rotacao
RotX = [1 0 0; 0 cos(ph) -sin(ph); 0 sin(ph) cos(ph)];
RotY = [cos(th) 0 sin(th); 0 1 0; -sin(th) 0 cos(th)];
RotZ = [cos(ps) -sin(ps) 0; sin(ps) cos(ps) 0; 0 0 1];

Rot = RotZ*RotY*RotX;

% Verificação de sequência dos robôs para criação da estrutura
seq = cross(Formacao.pPos.xd(4:6)-Formacao.pPos.xd(1:3),Formacao.pPos.xd(7:9)-Formacao.pPos.xd(1:3));
if seq(3) >= 0
    % Anti-horária: ABC -> z > 0
    % Posição desejada dos robôs
    posRobos = [Rot*[2/3*h1; 0; 0] + [xf;yf;zf];
        Rot*[2/3*h2*cos(a1);  2/3*h2*sin(a1); 0] + [xf;yf;zf];
        Rot*[2/3*h3*cos(a2); -2/3*h3*sin(a2); 0] + [xf;yf;zf]];
    
else
    % Horárica: ACB -> z < 0
    posRobos = [Rot*[2/3*h1; 0; 0] + [xf;yf;zf];
        Rot*[2/3*h2*cos(a1); -2/3*h2*sin(a1); 0] + [xf;yf;zf];
        Rot*[2/3*h3*cos(a2);  2/3*h3*sin(a2); 0] + [xf;yf;zf]];
    
end

if strcmp(cOUd,'c')
    Formacao.pPos.x = posRobos;
elseif strcmp(cOUd,'d')
    Formacao.pPos.xr = posRobos;
end


end