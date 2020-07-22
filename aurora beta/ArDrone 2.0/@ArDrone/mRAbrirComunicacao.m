function mRAbrirComunicacao(obj,IP,Local,Remota)

% Abrir Comunica��o para transmiss�o de dados entre dois computadores
% Princ�pio da estrat�gia descentralizada
%
% Importante notar que os computadores deve estar na mesma rede
obj.pUDP.Pc2Pc.Com =  udp(IP, 'RemotePort', Remota, 'LocalPort', Local);
set(obj.pUDP.Pc2Pc.Com ,'Timeout',0.1);
fopen(obj.pUDP.Pc2Pc.Com);
disp('Comunica��o PC-PC aberta')

% Dados Recebidos
% Sequ�ncia: o - Vazio, T - Transmitido, R - Recebido, E - Estabelecido
obj.pUDP.Pc2Pc.RxD = 'o';

% Dados Enviados
% Sequ�ncia: T - Transmitido, R - Recebido, E - Estabelecido
obj.pUDP.Pc2Pc.TxD = 'T'; 

% Vari�vel de Status indicando que comunica��o est� estabelecida
obj.pUDP.Pc2Pc.Status = 0;

end