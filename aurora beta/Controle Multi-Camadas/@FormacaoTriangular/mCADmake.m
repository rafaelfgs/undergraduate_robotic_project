function mCADmake(Formacao)

% Formação Desejada
Formacao.pCAD.Imag(1) = patch(Formacao.pPos.xd([1 4 7]),Formacao.pPos.xd([2 5 8]),Formacao.pPos.xd([3 6 9]),...
    'FaceColor',[1 0 1]);
Formacao.pCAD.Imag(1).FaceAlpha = 0.4;
Formacao.pCAD.Imag(1).EdgeColor = [1 1 1]*0.2;
Formacao.pCAD.Imag(1).LineStyle = '--';

% Formação Atual
Formacao.pCAD.Imag(2) = patch(Formacao.pPos.x([1 4 7]),Formacao.pPos.x([2 5 8]),Formacao.pPos.x([3 6 9]),...
    'FaceColor',[0 1 1]);
Formacao.pCAD.Imag(2).FaceAlpha = 0.4;
Formacao.pCAD.Imag(2).EdgeColor = [1 1 1]*0.2;
Formacao.pCAD.Imag(2).LineStyle = '-';

end