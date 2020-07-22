function mLerSensores(varargin) %(obj,TipoSensor,MetodoFusao,ID)
% mLerSensores fun��o destinada � leitura dos sensores determinado por sua
% identifica��o
%
% Tipo Sensor: C�lula que ir� conter os tipos de sensores a serem utilizados
% Poss�veis:
% - IMU: Sensores Internos - Unidade Inercial(Padr�o)
% - Optitrack
% - GPS
%
% Metodo de Fus�o: Informa o m�todo de atribui��o das vari�veis sensoriais
% � postura do ArDrone
% Poss�veis:
% - IMU: Sensores Internos - Unidade Inercial(Padr�o)
% - OPT: OptiTrack, ignora os dados dos sensores internos e atribui valor
% determinado pelo optitrack
% - IMUGPS: fus�o sensorial entre IMU e GPS
%
% ID: Identifica��o do corpo r�gido no espa�o de trabalho (Padr�o: 1)

% ObjectMak(1) = Sensores Internos
% ObjectMak(2) = OptiTrack
% ObjectMak(3) = GPS

nVarargs = length(varargin);
ObjectMak = zeros(length(varargin));
MetodoFusao = 0;

% Popula os objetos se os mesmo forem inclusos na fun��o
for k = 1:nVarargs
    if isobject(varargin{k})
        switch  varargin{k}.pTipo
            case 'ArDrone'
                ObjectMak(1) = k;
                Drone = varargin{k};
            case 'OptiTrack'
                ObjectMak(2) = k;
            case 'GPS'
                ObjectMak(3) = k;
            otherwise
                warning('Unexpected sensot type.')
        end
    elseif ischar(varargin{k}) % Determina o M�todo de MetodoFusao
        MetodoFusao = varargin{k};
    else % Determina o indentificador do OptiTrack
        ID = varargin{k};
    end
end


% for kk = 1:nVarargs
%     if isfloat(varargin{kk})
%         ID = varargin{kk};
%     end
% end


% Identifica��o do tipo do sensor, baseado no objeto de entrada
if ObjectMak(1) ~= 0 %'ArDrone'
    mLerIMU(varargin{ObjectMak(1)})
elseif ObjectMak(2) ~= 0
    mLerOptiTrack(varargin{ObjectMak(1)},varargin{ObjectMak(2)},ID)
end


% Determina��o do m�todo de fus�o dos dados para identifica��o da postura
% do ve�culo
switch MetodoFusao
    case 'IMU'
        Drone.pPos.X = Drone.pPos.Ximu;
    case 'OPT'
        Drone.pPos.X = Drone.pPos.Xopt;
    otherwise
        Drone.pPos.X = Drone.pPos.Ximu;
        % Ajustar e adicionar as vari�veis de velocidade da IMU nos valores
        % do optitrack
end


