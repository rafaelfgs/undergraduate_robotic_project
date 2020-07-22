function mCADdel(obj)

if isfield(obj.pCAD,'Imag')
    delete(obj.pCAD.Imag)
    obj.pCAD = rmfield(obj.pCAD,'Imag');
end

end