classdef ArDrone < handle
    % In a methods block, set the method attributes
    % and add the function signature
    properties
        pTipo       % ArDrone
        pPar        % Parametros
        pSC         % Sinal de Controle
        pPos        % Postura
        pUDP        % Vaiáreis de rede
        pDados      % Dados de voo e status
        pCAD        % Modelo CAD
        pCorCockpit % Cor do Cockpit
        pControlador% Dados relacionados ao controlador
        pTempo      % Variáveis de temporização
        pStatus
        pArquivo    % Arquivos de Dados
        pflag       % Flags para gerenciamento dos Dados
    end
    methods
        function obj = ArDrone
            obj.pTipo = 'ArDrone';
            mInit(obj);            
        end
        
        mInit(obj);
        
        % Função CAD para ilustrar AR.Drone na Posição Atual
        mCADmake(obj);
        mCADplot(obj,visible);
        mCADdel(obj);
        mCADcolor(obj,color);
        
        % Função CAD para ilustrar AR.Drone na Posição Desejada
        mCADmakeD(obj);
        mCADplotD(obj,visible);
        mCADdelD(obj);
        mCADcolorD(obj,color);
        
        % Função para controle autônomo de voo
        mControladorSubatuado(obj);
        mDefinirPostura(obj);
        mLerDadosSensores(obj);
        mEnviarSinaisControle(obj);
        mCalibrarSensores(obj);
        
        % Modelos do ArDrone
        mModeloBaixoNivel(obj);
        
        % OptiTrack
        mLerOptiTrack(obj,opt,id);
        mLerOptiTrackOffset(obj,opt,id);        
        
        % Conjunto de funções para interação com ArDrone Real : D - Drone
        mConectar(obj,IP);
        mCommand(obj, command_type, code);
        mTakeoff(obj);
        mHover(obj);
        mLand(obj);
        mEmergency(obj);
        mDrive(obj, speed);
        mStop(obj);
        
        % Comunicação em rede: R - Rede
        mRAbrirComunicacao(obj,IP,Local,Remota);
        mREstabelecerComunicacao(obj);       
        mRFecharComunicacao(obj);
        
        mRgs2pc(obj);
        mRpc2gs(obj);
        
        % Controle através de um Joystick
        mJoystick(obj,ID,Modelo);
        
        % Funções de Temporização
        mTimer(obj);
        
        % Arquivo de dados e Video
        mCriaArquivoDados(obj,video,objref);
        mSalvarDados(obj,objref);
        mFecharArquivoDados(obj);
    end
end