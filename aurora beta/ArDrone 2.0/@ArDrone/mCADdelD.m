function mCADdelD(obj)

if isfield(obj.pCAD,'ImagD')
    delete(obj.pCAD.ImagD)
    obj.pCAD = rmfield(obj.pCAD,'ImagD');
end

end