function Triangulos = mCriaTriangulos(Robos)

% Otimiza a criação de triângulos através do formalismo de Delaunay
% Os triângulos são formados segundo sua disponização no plano XY

for kk = 1:length(Robos);
    Xd(:,kk) = Robos{kk}.pPos.Xd(1:3);
end

% Criação dos Triângulos por Delaunay
Triangulos = delaunay(Xd(1,:),Xd(2,:));
