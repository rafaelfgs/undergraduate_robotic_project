function mInit(obj)

% Parametros do ArDrone v2.0

%% ========================================================================
% Aceleração da Gravidade
obj.pPar.Corpo.g = 9.8;

% Massa e Momento de Inérica
obj.pPar.Corpo.m = 0.380; %[kg]

obj.pPar.Corpo.Ixx = 9.57*1e-3; %8.197*1e-3; %[kg*m^2]
obj.pPar.Corpo.Iyy = 9.57*1e-3; %8.197*1e-3;
obj.pPar.Corpo.Izz = 25.55*1e-3; %16.365*1e-3;

obj.pPar.Corpo.Ixy = 0;%-0.91*0.45359237*2.54^2*1e-4;
obj.pPar.Corpo.Ixz = 0;%-2.08*0.45359237*2.54^2*1e-4;
obj.pPar.Corpo.Iyz = 0;%-0.02*0.45359237*2.54^2*1e-4;

%% ========================================================================
%Postura do ArDrone
obj.pPos.X    = zeros(12,1); % Postura Atual
obj.pPos.Xa   = zeros(12,1); % Postura Anterior

obj.pPos.Xd   = zeros(12,1); % Postura Desejada
obj.pPos.Xda  = zeros(12,1); % Postura Desejada Anterior

% Robo.X(3,:) = -Robo.CtrlGnd;

obj.pPos.Xtil = obj.pPos.Xd - obj.pPos.X; % Erro de postura

% Primeira derivada temporal da postura atual
obj.pPos.dX   = zeros(12,1);

% Primeira derivada temporal da postura desejada
obj.pPos.dXd   = zeros(12,1); 

% Yh = [p; q; r], taxa de rotação do veículo sobre o próprio eixo
obj.pPos.Y    = zeros(3,1); 

% Integral do erro
obj.pPos.IntXtil = zeros(12,1); 
%% ========================================================================
% Postura Desejada: Utilizado em controle cooperativo
obj.pPos.PD = zeros(12,1);
obj.pPos.PD(3,1) = 0.75;

%% ========================================================================
% Postura de referência para o quad-rotor
obj.pPos.Xr    = zeros(12,1); % Postura Atual de Referência

%% ========================================================================
% Dados sensoriais
% Dados sensoriais
obj.pPos.Xso   = zeros(12,1); % Postura definida pelos sensores: Condição Inicial
obj.pPos.Xs    = zeros(12,1); % Postura Atual definida pelos sensores
obj.pPos.Xsa   = zeros(12,1); % Postura Anterior definida pelos sensores
obj.pPos.dXs   = zeros(12,1); % Derivada da leitura sensorial
obj.pPos.Ys    = zeros(3,1);

% Unidade Inercial: IMU
obj.pPos.Ximuo   = zeros(12,1); % Postura definida: Condição Inicial
obj.pPos.Ximu    = zeros(12,1); % Postura Atual
obj.pPos.Ximua   = zeros(12,1); % Postura Anterior
obj.pPos.dXimu   = zeros(12,1); % Derivada da leitura sensorial
obj.pPos.Yimu    = zeros(3,1);

% OptiTrack: OPT
obj.pPos.Xopto   = zeros(12,1); % Postura definida: Condição Inicial
obj.pPos.Xopt    = zeros(12,1); % Postura Atual
obj.pPos.Xopta   = zeros(12,1); % Postura Anterior
obj.pPos.dXopt   = zeros(12,1); % Derivada da leitura sensorial
obj.pPos.Yopt    = zeros(3,1);

obj.pDados.bateria = zeros(1,1); % Nível de bateria durante um voo
obj.pDados.PWMmotor = zeros(4,1); % Sinal de PWM enviado aos motores
obj.pDados.SensorRaw = zeros(15,1); % Dados sensoriais sem tratamento

%% ArDrone: Forças aplicadas no sistema de referência espacial
obj.pSC.fTau = zeros(6,1);

% Forças de Referência
obj.pSC.Fr = zeros(4,1);
obj.pSC.Fra = zeros(4,1);
obj.pSC.dFr = zeros(4,1);

% Forças Propiciadas efetivamente pelos motores
obj.pSC.F  = zeros(4,1);
obj.pSC.Fr  = zeros(4,1);
obj.pSC.Fa = zeros(4,1);
obj.pSC.dF = zeros(4,1);

% Velocidade dadas pás
obj.pSC.W  = zeros(4,1);
obj.pSC.Wr = zeros(4,1);
obj.pSC.Wa = zeros(4,1);

obj.pSC.dW  = zeros(4,1);
obj.pSC.dWr = zeros(4,1);


% Tensão nos motores
obj.pSC.V  = zeros(4,1);
obj.pSC.Vr = zeros(4,1);

% Vetor de Distúrbio atuando na aeronave
obj.pSC.D = zeros(3,1);
obj.pSC.Q = zeros(3,1);

%% ========================================================================
% Variáveis resultantes de uma fusão sensorial
obj.pPos.Xf    = zeros(12,1);

%% ========================================================================
% Dados do GPS: Latitude, Longitude e Altura
obj.pPos.gpsID = 0;
obj.pPos.Xgps  = zeros(3,1);

%% Modelo Atuador ======================================
% JoyID indica se há um joystick com possibilidade de controlar o
% veículo e o seu ID de identificação para leitura dos dados.
% Caso seja diferente de zero, os valores de leitura e de referência são
% armazenados nas variáveis a seguir.
obj.pSC.Joystick.ID = 0;
obj.pSC.Joystick.OK = 0;

% Valores analógicos de referência
obj.pSC.Joystick.Ar = zeros(4,1);
% Valores digitais
obj.pSC.Joystick.Dr = zeros(15,1);

%% Modelo Propulsor ======================================
obj.pPar.Propulsor.k1 = 0.126*sqrt(2);
obj.pPar.Propulsor.k2 = 1.18e-7/4.0698e-6; 

%% Modelo Motor/Atuador ======================================
obj.pPar.Atuador.kdp = 1.0; 
obj.pPar.Atuador.kpp = 10.0;
obj.pPar.Atuador.kdt = 1.0;
obj.pPar.Atuador.kpt = 10.0;
obj.pPar.Atuador.kds = 0.01; %0.01
obj.pPar.Atuador.kps = 15; %15
obj.pPar.Atuador.kdz = 0.01; %0.01
obj.pPar.Atuador.kpz = 15;

obj.pPar.Atuador.r  = 10;
obj.pPar.Atuador.R  = 8.214;
obj.pPar.Atuador.Jm = 2.8e-8;
obj.pPar.Atuador.Bm = 1.06e-5;
obj.pPar.Atuador.Km = 0.39;
obj.pPar.Atuador.Kb = 8e-5;
obj.pPar.Atuador.Cf = 1.1429e-9;
obj.pPar.Atuador.Ct = -3.2e-11/obj.pPar.Atuador.r;

obj.pPar.Joystick.AngMax = 35/180*pi;
obj.pPar.Joystick.MaxRatePsi = 60/180*pi;
obj.pPar.Joystick.MaxRateZ = 0.25;

%% Parametros de Filtragem Arfagem e Rolagem
obj.pPar.Filtro.Ypred = zeros(2,1); % Preditor Linear
obj.pPar.Filtro.MSE   = eye(2)*1/180*pi; % Erro médio quadrático
obj.pPar.Filtro.VARW  = eye(2)*(1/180*pi)^2; % Variancia do estado ou do sistema
obj.pPar.Filtro.VARN  = eye(2)*(0.05/180*pi)^2; % Variancia da observacao

%% Tempo
obj.pTempo.Ts = 1/30;
obj.pTempo.Tce = tic;

%% Montar CAD ======================================================
obj.pCAD.ImagFlag = 0;
mCADmake(obj);
mCADmakeD(obj);

%% Variáveis de status
obj.pStatus.Conectado = 0;
obj.pStatus.Abortar = 0;

%% Controlador
obj.pControlador.Ganhos.OK = 0; % Ganhos do controlador inicialmente não carregados

%% Arquivo de Dados e Video
obj.pArquivo.Dados = [];
obj.pArquivo.Video = [];

%% Flags indicadores
obj.pflag.InitCabecalho = 0;
obj.pflag.SalvarXopt = 0;
obj.pflag.XoptOffset = 0;
obj.pflag.SalvarXgps = 0;
obj.pflag.SalvarXimu = 0;
obj.pflag.XimuOffset = 0;
obj.pflag.video = 0;

end