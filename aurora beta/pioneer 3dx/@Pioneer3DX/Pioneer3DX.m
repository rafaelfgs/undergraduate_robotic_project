classdef Pioneer3DX < handle
    % In a methods block, set the method attributes
    % and add the function signature
    properties
        pPar   % Parametros
        pSC    % Sinal de Controle
        pPos   % Postura
        pUDP   % Vai�reis de rede
        pDados % Dados de voo e status
        pCAD   % Modelo CAD
        pCorCockpit % Cor do Cockpit
        pControlador % Dados relacionados ao controlador
        pTempo % Vari�veis de temporiza��o
        pStatus 
        pID    % Identifica��o do Robo
        pPort
    end
    
    methods
        function obj = Pioneer3DX
            mInit(obj);            
        end
        
        mInit(obj);
        
        % Fun��o CAD para ilustrar Pioneer na Posi��o Atual
        mCADmake(obj);
        mCADplot(obj,visible);
        mCADplot2D(obj,visible);
        mCADdel(obj);
        % mCADcolor(obj,color);
        
        % Fun��o CAD para ilustrar AR.Drone na Posi��o Desejada
        % mCADmakeDes(obj);
        % mCADplotDes(obj,visible);
        % mCADplot2DDes(obj,visible);
        % mCADdelDes(obj);
        % mCADcolorDes(obj,color);
        
        % Fun��o para controle aut�nomo
        mDefinirPostura(obj);
        mLerDadosSensores(obj);
        mEnviarSinaisControle(obj);         
        
        mDefinirPosturaInicial(obj,Xo);
       
        % Conjunto de fun��es para intera��o com Pioneer Real
        mConectar(obj);        
        mDesconectar(obj);
        mConectarMobileSim(obj);        
        
        % Controle atrav�s de um Joystick
        % mJoystick(obj,ID,Modelo);

        % Fun��es de Temporiza��o
        mTimer(obj);
        
        % Arquivo de dados e Video
        % mCriaArquivoDados(obj,video,objref);
        % mSalvarDados(obj,objref);
        % mFecharArquivoDados(obj);
        
        % Fun��es para comunica��o em rede
        mBroadcastConectar(obj,ID);
        mBroadcastPublicar(obj);
        mBroadcastDesconectar(obj);
        
        
    end
end