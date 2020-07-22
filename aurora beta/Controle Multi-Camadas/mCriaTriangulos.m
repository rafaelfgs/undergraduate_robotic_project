function Triangulos = mCriaTriangulos(Robos)

% Otimiza a cria��o de tri�ngulos atrav�s do formalismo de Delaunay
% Os tri�ngulos s�o formados segundo sua disponiza��o no plano XY

for kk = 1:length(Robos);
    Xd(:,kk) = Robos{kk}.pPos.Xd(1:3);
end

% Cria��o dos Tri�ngulos por Delaunay
Triangulos = delaunay(Xd(1,:),Xd(2,:));
