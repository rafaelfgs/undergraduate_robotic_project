function mCADmake(obj)

obj.pCAD.S = loadawobj('ArDroneCADs.obj');
obj.pCAD.mtl = loadawmtl('ArDroneCADv5.mtl');

% Ajustando escala
% Extremos do CAD
vExt = minmax(obj.pCAD.S.v);
mExt = mean(vExt,2);
for ii = 1:3
    obj.pCAD.S.v(ii,:) = (obj.pCAD.S.v(ii,:) - mExt(ii))/1000;
end

obj.pCAD.Imag = patch('Vertices',obj.pCAD.S.v','Faces',obj.pCAD.S.f3');

for ii = 1:length(obj.pCAD.S.umat3)
    mtlnum = obj.pCAD.S.umat3(ii);
    for jj=1:length(obj.pCAD.mtl)
        if strcmp(obj.pCAD.mtl(jj).name,obj.pCAD.S.usemtl(mtlnum-1));
            break;
        end
    end
    fvcd3(ii,:) = obj.pCAD.mtl(jj).Kd';
    %fvcd(ii,:)=rand(1,3);
end

obj.pCAD.Imag.FaceVertexCData = fvcd3;
obj.pCAD.Imag.FaceColor = 'flat';
obj.pCAD.Imag.EdgeColor = 'none';
obj.pCAD.Imag.FaceAlpha = 0.6;
obj.pCAD.Imag.Visible = 'off';

end