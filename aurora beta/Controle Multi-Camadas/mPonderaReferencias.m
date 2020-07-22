function [Robos,ind] = mPonderaReferencias(Formacao,Triangulos,Robos)

% Pondera as posturas de refêrencia dos robôs em função de suas
% participações nos triângulos

ind = zeros(1,length(Robos));
for ii = 1:size(Triangulos,1)
    ind(Triangulos(ii,1)) = ind(Triangulos(ii,1)) + 1;
    ind(Triangulos(ii,2)) = ind(Triangulos(ii,2)) + 1;
    ind(Triangulos(ii,3)) = ind(Triangulos(ii,3)) + 1;
    
    Xaux{Triangulos(ii,1)}(:,ind(Triangulos(ii,1))) = Formacao(ii).pPos.xr(1:3);
    Xaux{Triangulos(ii,2)}(:,ind(Triangulos(ii,2))) = Formacao(ii).pPos.xr(4:6);
    Xaux{Triangulos(ii,3)}(:,ind(Triangulos(ii,3))) = Formacao(ii).pPos.xr(7:9);
    
    dXaux{Triangulos(ii,1)}(:,ind(Triangulos(ii,1))) = Formacao(ii).pPos.dxr(1:3);
    dXaux{Triangulos(ii,2)}(:,ind(Triangulos(ii,2))) = Formacao(ii).pPos.dxr(4:6);
    dXaux{Triangulos(ii,3)}(:,ind(Triangulos(ii,3))) = Formacao(ii).pPos.dxr(7:9);
end

% Atribuindo variáveis
for ii = 1:length(Robos)
   Robos{ii}.pPos.Xd(1:3)  = mean(Xaux{ii},2);
   Robos{ii}.pPos.dXd(1:3) = mean(dXaux{ii},2); 
end

end