function mRAbrirComunicacao(obj,IP,Local,Remota)

% Abrir Comunicação para transmissão de dados entre dois computadores
% Princípio da estratégia descentralizada
%
% Importante notar que os computadores deve estar na mesma rede
obj.pUDP.Pc2Pc.Com =  udp(IP, 'RemotePort', Remota, 'LocalPort', Local);
set(obj.pUDP.Pc2Pc.Com ,'Timeout',0.1);
fopen(obj.pUDP.Pc2Pc.Com);
disp('Comunicação PC-PC aberta')

% Dados Recebidos
% Sequência: o - Vazio, T - Transmitido, R - Recebido, E - Estabelecido
obj.pUDP.Pc2Pc.RxD = 'o';

% Dados Enviados
% Sequência: T - Transmitido, R - Recebido, E - Estabelecido
obj.pUDP.Pc2Pc.TxD = 'T'; 

% Variável de Status indicando que comunicação está estabelecida
obj.pUDP.Pc2Pc.Status = 0;

end