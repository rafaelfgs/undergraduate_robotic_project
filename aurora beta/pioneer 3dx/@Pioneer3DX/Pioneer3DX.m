classdef Pioneer3DX < handle
    % In a methods block, set the method attributes
    % and add the function signature
    properties
        pPar   % Parametros
        pSC    % Sinal de Controle
        pPos   % Postura
        pUDP   % Vaiáreis de rede
        pDados % Dados de voo e status
        pCAD   % Modelo CAD
        pCorCockpit % Cor do Cockpit
        pControlador % Dados relacionados ao controlador
        pTempo % Variáveis de temporização
        pStatus 
        pID    % Identificação do Robo
        pPort
    end
    
    methods
        function obj = Pioneer3DX
            mInit(obj);            
        end
        
        mInit(obj);
        
        % Função CAD para ilustrar Pioneer na Posição Atual
        mCADmake(obj);
        mCADplot(obj,visible);
        mCADplot2D(obj,visible);
        mCADdel(obj);
        % mCADcolor(obj,color);
        
        % Função CAD para ilustrar AR.Drone na Posição Desejada
        % mCADmakeDes(obj);
        % mCADplotDes(obj,visible);
        % mCADplot2DDes(obj,visible);
        % mCADdelDes(obj);
        % mCADcolorDes(obj,color);
        
        % Função para controle autônomo
        mDefinirPostura(obj);
        mLerDadosSensores(obj);
        mEnviarSinaisControle(obj);         
        
        mDefinirPosturaInicial(obj,Xo);
       
        % Conjunto de funções para interação com Pioneer Real
        mConectar(obj);        
        mDesconectar(obj);
        mConectarMobileSim(obj);        
        
        % Controle através de um Joystick
        % mJoystick(obj,ID,Modelo);

        % Funções de Temporização
        mTimer(obj);
        
        % Arquivo de dados e Video
        % mCriaArquivoDados(obj,video,objref);
        % mSalvarDados(obj,objref);
        % mFecharArquivoDados(obj);
        
        % Funções para comunicação em rede
        mBroadcastConectar(obj,ID);
        mBroadcastPublicar(obj);
        mBroadcastDesconectar(obj);
        
        
    end
end