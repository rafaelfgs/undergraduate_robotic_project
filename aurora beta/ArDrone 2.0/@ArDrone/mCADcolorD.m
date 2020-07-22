function mCADcolorD(obj,color)
obj.pCAD.mtl(1).Kd = color';

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

obj.pCAD.ImagD.FaceVertexCData = fvcd3;
end