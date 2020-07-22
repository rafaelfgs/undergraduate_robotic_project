function mCADmakeD(obj)

obj.pCAD.ImagD = patch('Vertices',obj.pCAD.S.v','Faces',obj.pCAD.S.f3');

obj.pCAD.ImagD.FaceVertexCData = obj.pCAD.Imag.FaceVertexCData;
obj.pCAD.ImagD.FaceColor = 'flat';
obj.pCAD.ImagD.EdgeColor = 'none';
obj.pCAD.ImagD.FaceAlpha = 0.3;
obj.pCAD.ImagD.Visible = 'off';

end