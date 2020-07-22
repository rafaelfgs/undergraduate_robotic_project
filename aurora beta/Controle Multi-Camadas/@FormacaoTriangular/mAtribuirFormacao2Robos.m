function Robos = mAtribuirFormacao2Robos(Formacao,Robos)

% Atribuindo variáveis
Robos{1}.pPos.Xd(1:3) = Formacao.pPos.xr(1:3);
Robos{2}.pPos.Xd(1:3) = Formacao.pPos.xr(4:6);
Robos{3}.pPos.Xd(1:3) = Formacao.pPos.xr(7:9);

Robos{1}.pPos.Xd(7:9) = Formacao.pPos.dxr(1:3);
Robos{2}.pPos.Xd(7:9) = Formacao.pPos.dxr(4:6);
Robos{3}.pPos.Xd(7:9) = Formacao.pPos.dxr(7:9);