function mBroadcastPublicar(obj)

% Construir mensagem do rob�
% Postura
% Derivada da Postura
% Velocidade linear e angular
ID = obj.pID; 

X = zeros(12,1);
X(1:length(obj.pPos.X)) = obj.pPos.Xs;

Ur = zeros(4,1);
Ur(1:length(obj.pSC.Ur)) = obj.pSC.Ur;

msg = sprintf('$POSX%u:%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,SC:%f,%f,%f,%f;',ID,X(1:12),Ur(1:4));
% Verificar se est� conectado para enviar. Apresentar uma notifica��o de
% erro e solicitar ao usu�rio que conecte usando a fun��o
% mBroadcastConectar

fprintf(obj.pUDP,msg);

end