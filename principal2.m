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
tTotal = tic;
tColetar = tic;
tEnviar = tic;
tPotencial = tic;
tMax = 120;

% Velocidades anteriores do rob�
u_co_antes = 0;
u_antes = 0;
d_co = inf;
k_co = inf;

% Ler postura inicial (l� obj.pPos.Xs) e o erro
P.mLerDadosSensores;
P.pPos.X = P.pPos.Xs;
P.pPos.Xd(6) = atan2(P.pPos.Xd(2)-P.pPos.X(2),P.pPos.Xd(1)-P.pPos.X(1));
P.pPos.Xtil = P.pPos.Xd-P.pPos.X;

% Iniciar vari�veis de hist�rico
X = P.pPos.X([1 2 6])';
Xd = P.pPos.Xd([1 2 6])';
Xtil = P.pPos.Xtil([1 2 6])';
U = P.pSC.U';
Ur = P.pSC.Ur';
T = toc(tTotal);

% Inicia a janela com o mapa utilizado
% figure
% plot(P.pPos.X(1),P.pPos.X(2),'ro','linewidth',2,'markersize',8)
% hold on
% desenharMapa
% plot(P.pPos.Xd(1),P.pPos.Xd(2),'ro','linewidth',2,'markersize',8)
% grid on
% axis([-6 6 -2 13])

% Loop at� tmax segundos
while toc(tTotal) < tMax
    
    % Coletar dados de 10 em 10ms
    if toc(tColetar) > .01
        
        % Vari�vel de tempo da coleta de dados
        tColetar = tic;
        
        % Ler postura inicial (l� obj.pPos.Xs) e o erro
        P.mLerDadosSensores;
        P.pPos.X = P.pPos.Xs;
        
        % Controle de trajet�ria
        % [P.pPos.Xd(1:2),P.pPos.dXd(1:2)] = Controlar_Circ(2,60,tTotal);
        [P.pPos.Xd(1:2),P.pPos.dXd(1:2)] = Controlar_Lemin(6,3,120,tTotal);
        % P.pPos.Xd(6) = atan2(P.pPos.Xd(2)-P.pPos.X(2),P.pPos.Xd(1)-P.pPos.X(1));
        
        % Erro
        P.pPos.Xtil = P.pPos.Xd-P.pPos.X;
        
        % Calcula as velocidades sem obst�culos
        [u_so,k] = Controlar_Tanh(P.pPos.Xtil(1:2),P.pPos.dXd(1:2),P.pPos.X(6),P.pPar.a);
        
        % Calcula as velocidades com obst�culos
        t_co = toc(tPotencial);
        [u_co,d_co,k_co] = campoPotencial(k(1),u_co_antes,P.pSC.U(1),u_antes,d_co,k_co,t_co);
        tPotencial = tic;
        
        % Determina a velocidade final do rob�
        P.pSC.Ur = u_so + u_co;
        
        if P.pSC.Ur(1)<-.1
            P.pSC.Ur = [0;0];
            P.mEnviarSinaisControle;
%             error(' ')
        end
        
        % Hist�rico da velocidade para calcular o fator de esquecimento e a acelera��o
        u_co_antes = u_co;
        u_antes = P.pSC.U(1);
        
    end
    
    % Enviar dados de 100 em 100ms
    if toc(tEnviar) > .1
        
        % Vari�vel de tempo de envio de dados
        tEnviar = tic;
        
        % disp([u_so',u_co'])
        
        % Hist�rico da posi��o atual, da desejada, do erro, das velocidades e do tempo
        X = [X;P.pPos.X([1 2 6])'];          %#ok<AGROW>
        Xd = [Xd;P.pPos.Xd([1 2 6])'];       %#ok<AGROW>
        Xtil = [Xtil;P.pPos.Xtil([1 2 6])']; %#ok<AGROW>
        U = [U;P.pSC.U'];                    %#ok<AGROW>
        Ur = [Ur; P.pSC.Ur'];                %#ok<AGROW>
        T = [T;toc(tTotal)];                 %#ok<AGROW>
        
        % Plota a cada instante a posi��o do rob�
        % try delete(h), catch, end
        % h = plot(X(:,1),X(:,2),'b-','linewidth',2);
        
        % Enviar sinais de controle para o rob�
        P.mEnviarSinaisControle;
        
    end
    
    drawnow
    
end

% hold off

% Envia velocidades 0 para o rob�
P.pSC.Ur = [0;0];
P.mEnviarSinaisControle;

% Calcula os erros
IAE = sum(rssq(Xtil(1:end-1,:),2).*diff(T));
ITAE = sum(rssq(Xtil(1:end-1,:),2).*T(1:end-1).*diff(T));
fprintf('IAE: %f     ITAE: %f     ERRO: %f\n',IAE,ITAE,rssq(Xtil(end,:),2));

% plotarResultados(X,Xtil(:,1:2),U,T,Controle,k,[0 1 1 1])

% salvarDados(X,Xd,Xtil,U,Ur,T,Controle,IAE)

% Desconectar o rob�
% P.mDesconectar;