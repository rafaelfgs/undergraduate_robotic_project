function mInit(obj)

% Parametros do Pionner P3DX

%% ========================================================================
%Postura do ArDrone
obj.pPos.X    = zeros(12,1); % Postura Atual
obj.pPos.Xa   = zeros(12,1); % Postura Anterior
obj.pPos.Xc    = zeros(12,1); % Postura Centro Robo

obj.pPos.Xd   = zeros(12,1); % Postura Desejada
obj.pPos.Xda  = zeros(12,1); % Postura Desejada Anterior

% Robo.X(3,:) = -Robo.CtrlGnd;

obj.pPos.Xtil = obj.pPos.Xd - obj.pPos.X; % Erro de postura

% Primeira derivada temporal da postura atual
obj.pPos.dX   = zeros(12,1);

% Primeira derivada temporal da postura desejada
obj.pPos.dXd   = zeros(12,1); 

% Yh = [p; q; r], taxa de rota��o do ve�culo sobre o pr�prio eixo
obj.pPos.Y    = zeros(3,1); 

% Integral do erro
obj.pPos.IntXtil = zeros(12,1); 

%% ========================================================================
% Postura de refer�ncia para o quad-rotor
obj.pPos.Xr    = zeros(12,1); % Postura Atual de Refer�ncia

% ========================================================================
% Dados sensoriais
obj.pPos.Xso   = zeros(12,1); % Postura definida pelos sensores: Condi��o Inicial
obj.pPos.Xs    = zeros(12,1); % Postura Atual definida pelos sensores
obj.pPos.Xsa   = zeros(12,1); % Postura Anterior definida pelos sensores
obj.pPos.dXs   = zeros(12,1); % Derivada da leitura sensorial
obj.pPos.Ys    = zeros(3,1);

obj.pDados.bateria = zeros(1,1); % N�vel de bateria

%% ========================================================================
% Acelera��o da Gravidade
obj.pPar.Corpo.g = 9.8;

% Massa e Momento de In�rica
obj.pPar.Corpo.m = 15; %[kg]

%% ========================================================================
% Vari�veis resultantes de uma fus�o sensorial
obj.pPos.Xf    = zeros(12,1);

%% ========================================================================
% Dados do GPS: Latitude, Longitude e Altura
obj.pPos.gpsID = 0;
obj.pPos.Xgps  = zeros(3,1);

%% Sinal de Controle ======================================================
% Velocidade linear e angular
obj.pSC.U = [0;0];  % Real
obj.pSC.Ur = [0;0]; % Referencia

%% Modelo Atuador ======================================
% JoyID indica se h� um joystick com possibilidade de controlar o
% ve�culo e o seu ID de identifica��o para leitura dos dados.
% Caso seja diferente de zero, os valores de leitura e de refer�ncia s�o
% armazenados nas vari�veis a seguir.
obj.pSC.Joystick.ID = 0;
obj.pSC.Joystick.OK = 0;

% Valores anal�gicos de refer�ncia
obj.pSC.Joystick.Ar = zeros(4,1);
% Valores digitais
obj.pSC.Joystick.Dr = zeros(15,1);

%% Tempo ======================================================
obj.pTempo.Ts = 0.1; %[s]

%% Montar CAD ======================================================
mCADmake(obj);
obj.pCorCockpit = [1 1 0]; % Amarelo padr�o

%% Par�metros
obj.pPar.a = 0.15; % [m] - ponto de controle
obj.pPar.Modelo = 'P3DX'; % modelo do robo

%% Vari�veis de status
obj.pStatus.Conectado = 0;
obj.pStatus.Abortar = 0;
obj.pStatus.Str = '';

end