function mCADplot(Formacao)

% Forma��o Desejada
Formacao.pCAD.Imag(1).Vertices = reshape(Formacao.pPos.xd,3,3)';

% Forma��o Atual
Formacao.pCAD.Imag(2).Vertices = reshape(Formacao.pPos.x,3,3)';

end