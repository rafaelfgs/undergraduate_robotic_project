function mCADplot(Formacao)

% Formação Desejada
Formacao.pCAD.Imag(1).Vertices = reshape(Formacao.pPos.xd,3,3)';

% Formação Atual
Formacao.pCAD.Imag(2).Vertices = reshape(Formacao.pPos.x,3,3)';

end