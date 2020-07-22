clear
close all
clc
try
    fclose(instrfindall)
end

addpath(genpath(pwd))

% Armazenar Dados Simula��o
cd('!Arquivo de Dados')
ArqDados = fopen([datestr(clock,30) '.txt'],'w');
cd ..

% Criar objetos
P = Pioneer3DX;
C = Consenso;

% Matriz de adjac�ncia dos rob�s
Madj = [0 1 1; 1 0 1; 1 1 0];


% Atribuir no consenso a matriz adjac�ncia
mMatrizAdjacenciaAtribuir(C,Madj);

%Set do ID do rob�
C.pVF.ID = input ('Digite o ID do rob�: ');
P.pID = C.pVF.ID;


%Conectar ao rob�
P.mConectar;

%Setar Postura inicial 
P.pPos.Xso([1 2 6]) = (input('Digita a postura inicial do rob�: '))';
P.mDefinirPosturaInicial(P.pPos.Xso([1 2 6]));

%Ler postura inicial (l� obj.pPos.Xs)
P.mLerDadosSensores;
P.pPos.X = P.pPos.Xs;

%Abrir conex�o do rob�
P.mBroadcastConectar;

%Abrir conex�es consenso
C.mConexoesCriar;
pause(2)
P.mBroadcastPublicar;
pause(2)

X = [];

t = tic;
tc = tic;
tei = tic;

while toc(t) < 30
    
    if toc(tc) > 0.1
        tc = tic;
        %Publicar informa��es na rede (obj.pID, obj.pPos.X,obj.pSC.Ur)
        P.mBroadcastPublicar;
        
        %Adquirir Informa��es da Rede
        C.mEstadoInformacaoPopular;
        
        %Setar postura inicial / Ler postura inicial (l� obj.pPos.Xs)
        P.mLerDadosSensores;
        P.pPos.X = P.pPos.Xs;

        %Atualizar os rob�s com os dados adquiridos por consenso
        P = C.mEstadoInformacaoAtualizar(P);

        %Calcular os sinais de controle com os dados atualizados
        P = fControladorPosicao(P);
        
        %Enviar sinais de controle para o rob�
        P.mEnviarSinaisControle;
        disp(C.pVF.Ei)
        
        X = [X [C.pVF.Eid; C.pVF.dEid]];
        
        % Armazenar Dados Simula��o
        fprintf(ArqDados,'%6.6f\t',toc(t));
        for kk = 1:C.pVF.nID
            fprintf(ArqDados,'%6.6f\t',C.pVF.X(:,kk)');
            fprintf(ArqDados,'%6.6f\t',C.pVF.SC(:,kk)');
        end
        fprintf(ArqDados,'\n');
    end
end

%Desconectar o rob�
P.mDesconectar;

fclose(ArqDados);

