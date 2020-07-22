function mCADplot(obj,visible)

% Exibe o ArDrone no espaco 3D de acordo com sua postura definida por
% X = [x y z psi theta phi dx dy dz dpsi dtheta dphi]^T

if nargin > 1
    obj.pCAD.Imag.Visible = visible;
end

% Atualizar postura
%%% Matriz de Rotacao
RotX = [1 0 0; 0 cos(obj.pPos.X(4)) -sin(obj.pPos.X(4)); 0 sin(obj.pPos.X(4)) cos(obj.pPos.X(4))];
RotY = [cos(obj.pPos.X(5)) 0 sin(obj.pPos.X(5)); 0 1 0; -sin(obj.pPos.X(5)) 0 cos(obj.pPos.X(5))];
RotZ = [cos(obj.pPos.X(6)) -sin(obj.pPos.X(6)) 0; sin(obj.pPos.X(6)) cos(obj.pPos.X(6)) 0; 0 0 1];

Rot = RotZ*RotY*RotX;
H = [Rot obj.pPos.X(1:3); 0 0 0 1];

vertices = H*[obj.pCAD.S.v; ones(1,size(obj.pCAD.S.v,2))];
obj.pCAD.Imag.Vertices = vertices(1:3,:)';

end