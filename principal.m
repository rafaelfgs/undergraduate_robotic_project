% Iniciar o programa
close all
clear
clc
try close(instrfindall), catch, end

% Adicionar os arquivos das outras pastas
addpath(genpath(pwd))

% Criar objetos
P = Pioneer3DX;

% Conectar ao rob� f�sico
% P.mConectar;

% Conectar ao rob� do simulador
P.mConectarMobileSim;

% Setar Postura inicial
P.mDefinirPosturaInicial([0 0 0]);

% Setar posi��o final
% P.pPos.Xd([1 2]) = [0 11];

% Iniciar vari�veis de tempo
T.total = tic;
T.coleta = tic;
T.envio = tic;
T.campo = tic;
T.max = 360;

% Ler postura inicial (l� obj.pPos.Xs) e o erro
P.mLerDadosSensores;
P.pPos.X = P.pPos.Xs;
P.pPos.Xd(6) = atan2(P.pPos.Xd(2)-P.pPos.X(2),P.pPos.Xd(1)-P.pPos.X(1));
P.pPos.Xtil = P.pPos.Xd-P.pPos.X;

% Iniciar vari�veis de hist�rico
H.T = toc(T.total);
H.X = P.pPos.X([1 2 6])';
H.Xd = P.pPos.Xd([1 2 6])';
H.Xtil = P.pPos.Xtil([1 2 6])';
H.U = P.pSC.U';
H.Ur = P.pSC.Ur';
H.Uso = [0 0];
H.Uco = [0 0];
H.Dco = inf;
H.Kco = inf;

% N�mero de itera��es
k = 1;

% Loop at� tmax segundos
while toc(T.total) < T.max
    
    % Coletar dados de 10 em 10ms
    if toc(T.coleta) > .01
        
        % Vari�vel de tempo da coleta de dados
        T.coleta = tic;
        
        % N�mero de itera��es
        k = k + 1;
        
        % Ler postura inicial (l� obj.pPos.Xs) e o erro
        P.mLerDadosSensores;
        P.pPos.X = P.pPos.Xs;
        
        % Controle de trajet�ria
        [P.pPos.Xd(1:2),P.pPos.dXd(1:2)] = Controlar_Circ(8,240,T.total);
        % [P.pPos.Xd(1:2),P.pPos.dXd(1:2)] = Controlar_Lemin(6,3,120,T.total);
        % P.pPos.Xd(6) = atan2(P.pPos.Xd(2)-P.pPos.X(2),P.pPos.Xd(1)-P.pPos.X(1));
        
        % Erro
        P.pPos.Xtil = P.pPos.Xd-P.pPos.X;
        
        % Calcula as velocidades sem obst�culos
        [uso,sat] = Controlar_Tanh(P.pPos.Xtil(1:2),P.pPos.dXd(1:2),P.pPos.X(6),P.pPar.a);
        
        % Calcula as velocidades com obst�culos
        tco = toc(T.campo);
        [uco,dco,kco] = campoPotencial(P.pSC.U(1),H.U(k-1,1),H.Uco(k-1,:),H.Dco(k-1),H.Kco(k-1),tco,sat);
        T.campo = tic;
        
        % Determina a velocidade final do rob�
        P.pSC.Ur = uso + uco;
        
        % Vari�veis de hist�rico
        H.T(k,:) = toc(T.total);
        H.X(k,:) = P.pPos.X([1 2 6])';
        H.Xd(k,:) = P.pPos.Xd([1 2 6])';
        H.Xtil(k,:) = P.pPos.Xtil([1 2 6])';
        H.U(k,:) = P.pSC.U';
        H.Ur(k,:) = P.pSC.Ur';
        H.Uso(k,:) = uso';
        H.Uco(k,:) = uco';
        H.Dco(k,:) = dco;
        H.Kco(k,:) = kco;
        
    end
    
    % Envia dados de 100 em 100ms
    if toc(T.envio) > .1
        T.envio = tic;
        P.mEnviarSinaisControle;
    end
    
    drawnow
    
end

% Envia velocidades 0 para o rob�
P.pSC.Ur = [0;0];
P.mEnviarSinaisControle;

% Desconectar o rob�
% P.mDesconectar;