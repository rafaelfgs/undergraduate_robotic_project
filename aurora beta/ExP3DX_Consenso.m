clear 
close all
clc
try
    fclose(instrfindall)
end

addpath(genpath(pwd))

%inserir matriz Adjacencia
Madj = [0 0 1;
        1 0 0;
        0 1 0];


P = Pioneer3DX; % cria 
P.pID = input('Digite o ID do Robo: '); % Recebe ID
while P.pID  < 1 || P.pID > length(Madj)
    P.pID  = input('ID inválido! Digite o ID do Robo: ');
end
%  P.pPort  = input('Digite a porta do simulador: ');
 
P.mConectar;
poseInicial = input('Pose Inicial:[] ');
if isempty(poseInicial )
    poseInicial = [0 0 0];
end
arrobot_setpose(poseInicial(1), poseInicial(2), poseInicial(3));

P.mBroadcastConectar; %Conectar para enviar em Broadcast

% criar as conexões UDP para receber dados
Conexoes = CriarnUDP(Madj);

% inicializar as posições dos agentes igual a NaN porque a posição inicial
% dos agentes é desconhecida;
Xj = NaN(3,length(Madj));

% inicilizar X 

% ?????

% Botão de Emergencia
F = figure;
bot = uicontrol(F, 'style', 'pushbutton', 'units', 'normalized', ...
    'position', [.1 .1 .8 .8], 'string', 'Parar', 'Fontsize', 50, ...
    'callback', 'ParadaSeguranca');
ParadaSeguranca


P.pTempo.Tce = tic;
consenso = 0; % consenso obtido
while ~consenso
    
    if P.mPermissaoExecucao
        P.mLerDadosSensores
        P.pPos.X = P.pPos.Xs; %????????????????????????????/ por que não? Está comentado na mLerDadosSensores
        
        % Popular/Atualizar Xj
        Xj = popularPosicoesDosAgentes(Xj, Conexoes);
        Xj(:,P.pID) = P.pPos.X(1:3);
      
        %calcular dXi
        Xi = P.pPos.X(1:3)*ones(1,length(Madj));
        dist = (Xj-Xi);
        dist(isnan(dist)) = 0;
        dXi = dist * Madj(P.pID,:)';
        
        
        P = atualizarXd(P,dXi);
        
        P.pSC.Ur =  calculaSC(P);
        P.mEnviarSinaisControle
        
        P.mBroadcastPublicar;
        disp(P.pPos.X([1 2 6]))
    end
    drawnow
end
