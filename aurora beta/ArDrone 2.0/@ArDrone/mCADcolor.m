function mCADcolor(obj,color)

if nargin > 1
    obj.pCAD.mtl(1).Kd = color';
end

for ii = 1:length(obj.pCAD.S.umat3)
    mtlnum = obj.pCAD.S.umat3(ii);
    for jj=1:length(obj.pCAD.mtl)
        if strcmp(obj.pCAD.mtl(jj).name,obj.pCAD.S.usemtl(mtlnum-1));
            break;
        end
    end
    fvcd3(ii,:) = obj.pCAD.mtl(jj).Kd';
end

obj.pCAD.Imag.FaceVertexCData  = fvcd3;
obj.pCAD.ImagD.FaceVertexCData = fvcd3;
end