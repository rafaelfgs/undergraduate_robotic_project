function mCADplotD(obj,visible)

% Exibe o ArDrone no espaco 3D de acordo com sua postura definida por
% X = [x y z psi theta phi dx dy dz dpsi dtheta dphi]^T

if nargin > 1
    obj.pCAD.ImagD.Visible = visible;
end

% Atualizar postura
%%% Matriz de Rotacao
RotX = [1 0 0; 0 cos(obj.pPos.Xd(4)) -sin(obj.pPos.Xd(4)); 0 sin(obj.pPos.Xd(4)) cos(obj.pPos.Xd(4))];
RotY = [cos(obj.pPos.Xd(5)) 0 sin(obj.pPos.Xd(5)); 0 1 0; -sin(obj.pPos.Xd(5)) 0 cos(obj.pPos.Xd(5))];
RotZ = [cos(obj.pPos.Xd(6)) -sin(obj.pPos.Xd(6)) 0; sin(obj.pPos.Xd(6)) cos(obj.pPos.Xd(6)) 0; 0 0 1];

Rot = RotZ*RotY*RotX;
H = [Rot obj.pPos.Xd(1:3); 0 0 0 1];

vertices = H*[obj.pCAD.S.v; ones(1,size(obj.pCAD.S.v,2))];
obj.pCAD.ImagD.Vertices = vertices(1:3,:)';

end