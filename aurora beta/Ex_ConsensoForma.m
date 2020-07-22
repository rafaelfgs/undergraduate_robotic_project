clear
close all
clc

try
    fclose(instrfindall)
end

addpath(genpath(pwd))

% Parametros da trajetoria
rx = 2;
ry = .8;
f = 0.0075;

% Armazenar Dados Simulação
% cd('!Arquivo de Dados Experimento')
% ArqDados = fopen([datestr(clock,30) '.txt'],'w');
% cd ..

% Identificar o computador q rodou a simulação
% !hostname > hostname.txt
% host = textread('hostname.txt','%s'); 
% fprintf(ArqDados, 'Experimento %s\r\n', host{1});
% delete('hostname.txt');

% figure
% axis([-3 3 -3 3])
% hold on

% Matriz de adjacência dos robôs
Madj = [0 0 0 0 0; 
        10 0 0 0 0; 
        1 1 0 0 0; 
        0 0 0 0 0; 
        0 0 0 0 0];
% Madj = [ 0 0 0 0;
%         10 0 1 1; 
%         10 1 0 1; 
%         10 1 1 0];

% Madj = [0 0 0 0 0; 
%         10 0 0 0 0; 
%         0 10 0 0 0; 
%         0 0 50 0 0; 
%         0 0 0 50 0];

% Criar objetos
P = Pioneer3DX;
C = Consenso;
P.pID = input('ID do Robo: ');
while P.pID < 2 || P.pID > 5
    P.pID = input('ID do Robo: ');
end
C.pVF.ID = P.pID;

% P.mConectar;
% P.mConectarMobileSim;
% P.pPar.a = .10;
% Atribuir no consenso a matriz adjacência
mMatrizAdjacenciaAtribuir(C,Madj);

%Setar Postura inicial
P.pPos.Xso([1 2 6]) = input('Postura Inicial do Robo: ');
P.mDefinirPosturaInicial(P.pPos.Xso([1 2 6]));

%Ler postura inicial (lê obj.pPos.Xs)
P.mLerDadosSensores;
P.pPos.X = P.pPos.Xs;
% Rastro = P.pPos.X(1:2)*ones(1,200);
% Rastro2 = P.pPos.X(1:2)*ones(1,200);
Rastro = nan(2,1);
Rastro2 = nan(2,1);

P.mBroadcastConectar;
C.mConexoesCriar;
P.mBroadcastPublicar;

if P.pID == 2
    Pv = Pioneer3DX;
    Pv.pID = 1;
    Pv.pPos.Xs([1 2 6]) = [0 0 0];
    Pv.pPos.X = Pv.pPos.Xs;    
    Pv.mBroadcastConectar;
    Pv.mBroadcastPublicar;
    disp('Virtual criado');
end

% Formação desejada baseada no consenso
aa = .8;
C.pVF.XF = [0 0 0; 
            1 0 0 ; 
            0 1 0; 
           -1 0 0; 
           0 -1 0]'*aa;

X = [];


RODAR = 1;

% Históricos
hSC = [];
hXd = [];

thist = tic;
pause(0.01);
tc = tic;
tr = tic;
tc2 = tic;
t = tic;
tp = tic;
tei = tic;
tPv = tic;
tPvEstado = 1;
tdisp = tic;


while RODAR
    if toc(thist) >= .01
        thist = tic;
        hSC = [hSC; toc(t) P.pSC.Ur' arrobot_getvel arrobot_getrotvel]; 
        hXd = [hXd; toc(t) P.pPos.Xd([1 2 7 8])'];
        
    end
    
    if toc(tdisp) > 1
        tdisp = tic;
%         disp('.')
       disp( [P.pPos.X([1 2 6]) P.pPos.Xd([1 2 6])])
    end
    
    % Malha controle robo virtual
    if P.pID == 2 && toc(tc2) >= 0.1
        tc2 = tic;
        pausa = 0.0001;
        switch (tPvEstado)
            case 1
                phi = 0;
                if toc(tPv) > 25
                    phi = 0;
%                     RODAR = 0;
                    tPvEstado = 2;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                end
            case 2
                if 2*pi*f*toc(tPv) >= pi/2
                    phi = pi/2;
                    tPvEstado = 3;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                end
            case 3
                if toc(tPv) > pausa
                    phi = pi/2;
                    tPvEstado = 4;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                end
            case 4
                if 2*pi*f*toc(tPv) >= pi/2
                    phi = pi;
                    tPvEstado = 5;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                end
            case 5
                if toc(tPv) > pausa
                    phi = pi;
                    tPvEstado = 6;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                end
            case 6
                if 2*pi*f*toc(tPv) >= pi/2
                    phi = 3*pi/2;
                    tPvEstado = 7;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                end
            case 7
                if toc(tPv) > pausa
                    phi = 3*pi/2;
                    tPvEstado = 8;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                end
            case 8
                if 2*pi*f*toc(tPv) >= pi/2
                    tPvEstado = 9;
                    tPv = tic;
                    disp(['Caso' num2str(tPvEstado)]);
                    phi = 2*pi;
                end
                
            case 9
                 if toc(tPv) > 15
%                      RODAR = 0;
                     tPv = tic;
                     tPvEstado = 11;
                     disp(['Caso' num2str(tPvEstado)]);
                 end
            otherwise
                phi = 3*pi/2;
                if toc(tPv) > 15
                    RODAR = 0;
                    tPv = tic;
                    disp(['Fim']);
                end  
        end
        
        if mod(tPvEstado,2)
            Pv.pPos.X(1) = rx*sin(phi);
            Pv.pPos.X(2) = ry*sin(2*phi);
            Pv.pPos.X(7) = rx*2*pi*0.01*cos(phi);
            Pv.pPos.X(8) = ry*4*pi*0.01*cos(2*phi);
        else
            
            Pv.pPos.X(1) = rx*sin(2*pi*f*toc(tPv) + phi);
            Pv.pPos.X(2) = ry*sin(2*(2*pi*f*toc(tPv) + phi));
            Pv.pPos.X(7) = rx*2*pi*0.01*cos(2*pi*f*toc(tPv) + phi);
            Pv.pPos.X(8) = ry*4*pi*0.01*cos(2*(2*pi*f*toc(tPv) + phi));
        end
        
        Pv.pPos.Xs = Pv.pPos.X;
        %Publicar informações na rede (obj.pID, obj.pPos.X,obj.pSC.Ur)
        Pv.mBroadcastPublicar;
        
    end
    
    % Malha de controle do Consenso
    if toc(tc) >= .1
        tc = tic;
        tempoPassado = toc(t);
        
        %Enviar informações do Pioneer
        %Publicar informações na rede (obj.pID, obj.pPos.X,obj.pSC.Ur)
        P.mBroadcastPublicar;
        
        % Adquirir Informações da Rede
        C.mEstadoInformacaoPopular(P);
        
        %Setar postura inicial / Ler postura inicial (lê obj.pPos.Xs
        P.mLerDadosSensores;
        P.pPos.X = P.pPos.Xs;
        
        %Atualizar os robôs com os dados adquiridos por consenso
        P = C.mEstadoInformacaoAtualizar(P);
%     end
%     
%     % Malha controle robô
%     if toc(tr) >= 1/4
%         tr = tic;
%         
%         %Setar postura inicial / Ler postura inicial (lê obj.pPos.Xs
%         P.mLerDadosSensores;
%         P.pPos.X = P.pPos.Xs;
%         
        %Atualizar os robôs com os dados adquiridos por consenso
%         P = C.mEstadoInformacaoAtualizar(P);
        
        %Calcular os sinais de controle com os dados atualizados
        P = fControladorPosicao(P);
    
        %Enviar sinais de controle para o robô
        P.mEnviarSinaisControle;
        
        % Rastro Navegação
%         Rastro = [Rastro(:,2:end) P.pPos.X(1:2)];
        Rastro = [Rastro P.pPos.X(1:2)];
        Rastro2 = [Rastro2 P.pPos.Xd(1:2)];
        
        %disp(C.pVF.Ei)
        
        X = [X [C.pVF.Eid; C.pVF.dEid]];
        
        % Armazenar Dados Simulação
%         fprintf(ArqDados,'%6.6f\t',tempoPassado);
%         for kk = 1:C.pVF.nID
%             fprintf(ArqDados,'%6.06f\t',C.pVF.X(:,kk)');
%             fprintf(ArqDados,'%6.06f\t',C.pVF.SC(:,kk)');
%         end
%         fprintf(ArqDados,'\r\n');
        
       
    end
    
    if toc(tp) > 0.2
        tp = tic;
        try
            delete(h1)
            delete(h2)
            delete(h3)
            delete(h4)
            delete(h5)
            
        end
        
        h1 = plot(Pv.pPos.X(1), Pv.pPos.X(2), 'r*');
        hold on
        h2 = plot(P.pPos.X(1), P.pPos.X(2), 'bo');
        h3 = plot(P.pPos.Xd(1), P.pPos.Xd(2), 'rs');
        h4 = plot(Rastro(1,:),Rastro(2,:), 'k-');
        h5 = plot(Rastro2(1,:),Rastro2(2,:), 'r-');
        axis([-3 3 -3 3]);
        drawnow
    end
    
end
P.pSC.Ur = [0; 0];
P.mEnviarSinaisControle;
% P.mDesconectar;

% fclose(ArqDados);

figure
subplot(2,1,1)
plot(hSC(:,1), hSC(:,2)*1000,'r', hSC(:,1), hSC(:,4), 'b');
title('Sinal de controle desejado/real ')
subplot(2,1,2)
plot(hSC(:,1), hSC(:,3)/pi*180,'r', hSC(:,1), hSC(:,5), 'b');

figure
plot(hXd(:,1), hXd(:,4),'r', hXd(:,1), hXd(:,5), 'b');
title('Derivada Xd')

figure
plot(hXd(:,1), hXd(:,2),'r', hXd(:,1), hXd(:,3), 'b');
title('Xd')