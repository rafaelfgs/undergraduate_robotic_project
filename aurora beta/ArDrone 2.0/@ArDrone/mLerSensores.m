function mLerSensores(varargin) %(obj,TipoSensor,MetodoFusao,ID)
% mLerSensores função destinada à leitura dos sensores determinado por sua
% identificação
%
% Tipo Sensor: Célula que irá conter os tipos de sensores a serem utilizados
% Possíveis:
% - IMU: Sensores Internos - Unidade Inercial(Padrão)
% - Optitrack
% - GPS
%
% Metodo de Fusão: Informa o método de atribuição das variáveis sensoriais
% à postura do ArDrone
% Possíveis:
% - IMU: Sensores Internos - Unidade Inercial(Padrão)
% - OPT: OptiTrack, ignora os dados dos sensores internos e atribui valor
% determinado pelo optitrack
% - IMUGPS: fusão sensorial entre IMU e GPS
%
% ID: Identificação do corpo rígido no espaço de trabalho (Padrão: 1)

% ObjectMak(1) = Sensores Internos
% ObjectMak(2) = OptiTrack
% ObjectMak(3) = GPS

nVarargs = length(varargin);
ObjectMak = zeros(length(varargin));
MetodoFusao = 0;

% Popula os objetos se os mesmo forem inclusos na função
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
    elseif ischar(varargin{k}) % Determina o Método de MetodoFusao
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


% Identificação do tipo do sensor, baseado no objeto de entrada
if ObjectMak(1) ~= 0 %'ArDrone'
    mLerIMU(varargin{ObjectMak(1)})
elseif ObjectMak(2) ~= 0
    mLerOptiTrack(varargin{ObjectMak(1)},varargin{ObjectMak(2)},ID)
end


% Determinação do método de fusão dos dados para identificação da postura
% do veículo
switch MetodoFusao
    case 'IMU'
        Drone.pPos.X = Drone.pPos.Ximu;
    case 'OPT'
        Drone.pPos.X = Drone.pPos.Xopt;
    otherwise
        Drone.pPos.X = Drone.pPos.Ximu;
        % Ajustar e adicionar as variáveis de velocidade da IMU nos valores
        % do optitrack
end


