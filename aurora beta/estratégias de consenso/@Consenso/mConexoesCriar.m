function mConexoesCriar(obj)

% Fun��o que cria as conex�es com os demais rob�s que comp�em a forma��o
% baseada em consenso
%
% Esta fun��o somente ser� chamada, quando um experimento estiver sendo
% realizado. 

obj.pVC.ConexoesFlag = 1;

for ii = 1:obj.pVF.nID    
    obj.pVC.Conexoes(ii) = udp('255.255.255.255', 'localPort', 25000+ii);    
end

fopen(obj.pVC.Conexoes);

end