function mAtribuirRobos2Formacao(Formacao,Robos,cOUd)

if strcmp(cOUd,'c')
    Formacao.pPos.x  = [Robos{1}.pPos.X(1:3);Robos{2}.pPos.X(1:3);Robos{3}.pPos.X(1:3)];
    Formacao.pPos.dx = [Robos{1}.pPos.X(7:9);Robos{2}.pPos.X(7:9);Robos{3}.pPos.X(7:9)];
    
elseif strcmp(cOUd,'d')
    Formacao.pPos.xd  = [Robos{1}.pPos.Xd(1:3);Robos{2}.pPos.Xd(1:3);Robos{3}.pPos.Xd(1:3)];
    Formacao.pPos.dxd = [Robos{1}.pPos.Xd(7:9);Robos{2}.pPos.Xd(7:9);Robos{3}.pPos.Xd(7:9)];

else
    disp('Selecione ''c'' ou ''d''')
end
end
