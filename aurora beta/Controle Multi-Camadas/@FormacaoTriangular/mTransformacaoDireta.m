function mTransformacaoDireta(Formacao,cOUd)

if strcmp(cOUd,'c')
    posRobos = Formacao.pPos.x;
elseif strcmp(cOUd,'d')
    posRobos = Formacao.pPos.xd;
else
    disp('cOUd deve ser ''c'' para valores correntes ou ''d'' para valores desejados')
end

% Coordenadas do baricentro da formação (xf,yf,zf)
x = (posRobos(1)+posRobos(4)+posRobos(7))/3;
y = (posRobos(2)+posRobos(5)+posRobos(8))/3;
z = (posRobos(3)+posRobos(6)+posRobos(9))/3;
% Orientação da formação
ph =  atan((2*posRobos(6)-posRobos(3)-posRobos(9))/(2*posRobos(5)-posRobos(2)-posRobos(8)));
th = -atan((2*posRobos(3)-posRobos(6)-posRobos(9))/(2*posRobos(1)-posRobos(4)-posRobos(7)));
ps =  atan2((2*posRobos(2)-posRobos(5)-posRobos(8)),(2*posRobos(1)-posRobos(4)-posRobos(7)));
% Lados do triângulo
p = sqrt((posRobos(1)-posRobos(4))^2+(posRobos(2)-posRobos(5))^2+(posRobos(3)-posRobos(6))^2);
q = sqrt((posRobos(1)-posRobos(7))^2+(posRobos(2)-posRobos(8))^2+(posRobos(3)-posRobos(9))^2);
r = sqrt((posRobos(4)-posRobos(7))^2+(posRobos(5)-posRobos(8))^2+(posRobos(6)-posRobos(9))^2);
% Ângulo de abertura dos robôs 2 e 3 em relação ao R1
b = acos((p^2+q^2-(r^2))/(2*p*q));

posFormacao = [x y z ph th ps p q b]';

if strcmp(cOUd,'c')
    Formacao.pPos.q = posFormacao;
elseif strcmp(cOUd,'d')
    Formacao.pPos.qd = posFormacao;
end
end