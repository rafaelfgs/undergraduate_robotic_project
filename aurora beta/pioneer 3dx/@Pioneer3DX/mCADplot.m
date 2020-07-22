function mPlotar3D(obj)

obj.pCAD.CockpitColor = obj.pCorCockpit;

% Exibe o ArDrone no espaco 3D de acordo com sua postura definida por
% X = [x y z psi theta phi dx dy dz dpsi dtheta dphi]^T
% obj.pCAD.Face indica o grau de transparencia de cada parte do veiculo

%%% Matriz de Rotacao
RotX = [1 0 0; 0 cos(obj.pPos.Xc(4)) -sin(obj.pPos.Xc(4)); 0 sin(obj.pPos.Xc(4)) cos(obj.pPos.Xc(4))];
RotY = [cos(obj.pPos.Xc(5)) 0 sin(obj.pPos.Xc(5)); 0 1 0; -sin(obj.pPos.Xc(5)) 0 cos(obj.pPos.Xc(5))];
RotZ = [cos(obj.pPos.Xc(6)) -sin(obj.pPos.Xc(6)) 0; sin(obj.pPos.Xc(6)) cos(obj.pPos.Xc(6)) 0; 0 0 1];

Rot = RotZ*RotY*RotX;

% ObjImag das partes do robô

% vértices
for k = 1:size(obj.pCAD.vertices,2)
    r1 = Rot * obj.pCAD.vertices{k};
    obj.pCAD.ObjImag(k) = patch(r1(1,:)+obj.pPos.Xc(1), r1(2,:)+obj.pPos.Xc(2), r1(3,:)+obj.pPos.Xc(3),'k');
end
indice = k;

% rodas
for k=1:size(obj.pCAD.rodas,2)
    indice = indice + 1;
    r3 = Rot * obj.pCAD.rodas{k};
    obj.pCAD.ObjImag(indice) = patch(r3(1,:)+obj.pPos.Xc(1), r3(2,:)+obj.pPos.Xc(2), r3(3,:)+obj.pPos.Xc(3),'k');    
end

% tronco
for k=1:size(obj.pCAD.corpo,2)
    indice = indice +1;
    r4 = Rot * obj.pCAD.corpo{k};
    obj.pCAD.ObjImag(indice) = patch(r4(1,:)+obj.pPos.Xc(1), r4(2,:)+obj.pPos.Xc(2), r4(3,:)+obj.pPos.Xc(3),'r');
end

end