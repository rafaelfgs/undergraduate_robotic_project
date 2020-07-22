function mDefinirPostura(obj)

% mDefinirPostura determina a postura do ArDrone baseado em seu modelo
% dinâmico obtido segundo as equações de Euler Lagrange

% =================================================================
% =================================================================
% comando pitch (desde Matlab, entre -1 y 1, +-12 grados)
% comando roll (desde Matlab, entre -1 y 1, +-12 grados)
% comando yaw (desde Matlab, entre -1 y 1, +-100 grados/segundo)
% comando gaz (desde Matlab, entre -1 y 1, +- 0.7 m/s)

% Robo = ArDrone_Joystick(Robo)
% Esta funcao recebe os comandos obtidos através de um joystick e envia
% como parametros de referencia para o ArDrone
%
% Os comando sao enviados através da alavancas analogicas e sao dados por
% [pitch roll yaw_rate z_dot]
%
% Os comandos do joystick são normalizados entre [-1 1], que equivalem
% pitch:   [-12 12] graus
% roll:    [-12 12] graus
% dot_yaw: [-10 10] graus/s
% dot_z:   [0.7 0.7] m/s

% Os dados de referencia enviados pelo Joystick sao representados no
% sistema de referencia da aeronave

% Comandos de referência enviados pelo joystick
obj.pPos.Xra = obj.pPos.Xr;

obj.pPos.Xr(5)  = -obj.pSC.Joystick.Ar(1)*obj.pPar.Joystick.AngMax;
obj.pPos.Xr(4)  =  obj.pSC.Joystick.Ar(2)*obj.pPar.Joystick.AngMax;
obj.pPos.Xr(12) = -obj.pSC.Joystick.Ar(3)*obj.pPar.Joystick.MaxRatePsi;
obj.pPos.Xr(9)  =  obj.pSC.Joystick.Ar(4)*obj.pPar.Joystick.MaxRateZ;

% Recebe erros de referências e retorna força a ser aplicada ao modelo de
% corpo rígido do veículo

% 1: erro -> V
obj.pSC.Vor = (obj.pPar.Atuador.R*obj.pPar.Atuador.Bm/obj.pPar.Atuador.Km + obj.pPar.Atuador.Kb)*...
    sqrt(obj.pPar.Corpo.m*obj.pPar.Corpo.g/4/obj.pPar.Atuador.Cf) + ...
    obj.pPar.Atuador.R*obj.pPar.Atuador.Ct/obj.pPar.Atuador.Km*obj.pPar.Corpo.m*obj.pPar.Corpo.g/4/obj.pPar.Atuador.Cf;

obj.pSC.V = obj.pSC.Vor + [1 -1 1 1; 1 1 -1 1; -1 1 1 1; -1 -1 -1 1]*...
    [obj.pPar.Atuador.kdp*(obj.pPos.Xr(4)-obj.pPos.X(4)  - obj.pPos.Xra(4) +obj.pPos.Xa(4) )/obj.pTempo.Ts  + obj.pPar.Atuador.kpp*(obj.pPos.Xr(4)-obj.pPos.X(4));
    obj.pPar.Atuador.kdt*(obj.pPos.Xr(5) -obj.pPos.X(5)  - obj.pPos.Xra(5) +obj.pPos.Xa(5) )/obj.pTempo.Ts  + obj.pPar.Atuador.kpt*(obj.pPos.Xr(5)-obj.pPos.X(5));
    obj.pPar.Atuador.kds*(obj.pPos.Xr(12)-obj.pPos.X(12) - obj.pPos.Xra(12)+obj.pPos.Xa(12))/obj.pTempo.Ts  + obj.pPar.Atuador.kps*(obj.pPos.Xr(12)-obj.pPos.X(12));
    obj.pPar.Atuador.kdz*(obj.pPos.Xr(9) -obj.pPos.X(9)  - obj.pPos.Xra(9) +obj.pPos.Xa(9) )/obj.pTempo.Ts  + obj.pPar.Atuador.kpz*(obj.pPos.Xr(9)-obj.pPos.X(9))];

% Saturação dos motores dado pelos limites da fonte de energia
obj.pSC.V = (obj.pSC.V>0).*obj.pSC.V;
obj.pSC.V = (obj.pSC.V<=11.1).*obj.pSC.V + (obj.pSC.V>11.1).*11.1;

% 2: V -> W
%obo.W = 1/(obj.AtuadorRef.Jm*obj.AtuadorRef.R+obj.Ts*(obj.AtuadorRef.Bm*obj.AtuadorRef.R+obj.AtuadorRef.Km*obj.AtuadorRef.Kb))*...
%     (obj.AtuadorRef.Jm*obj.AtuadorRef.R*obj.W(:,obj.na-1)+obj.Ts*(obj.AtuadorRef.Km*obj.V)-obj.Ts*obj.Atuador.R*obj.Atuador.Ct*obj.W(:,obj.na-1).^2);
obj.pSC.W = 1/(obj.pPar.Atuador.Jm+obj.pTempo.Ts*(obj.pPar.Atuador.Bm+obj.pPar.Atuador.Km*obj.pPar.Atuador.Kb/obj.pPar.Atuador.R))*...
    (obj.pPar.Atuador.Jm*obj.pSC.Wa+obj.pTempo.Ts*(obj.pPar.Atuador.Km/obj.pPar.Atuador.R*obj.pSC.V-obj.pPar.Atuador.Ct*obj.pSC.Wa.^2));
obj.pSC.dW = (obj.pSC.W - obj.pSC.Wa)/obj.pTempo.Ts;

% 3: W -> F
% Deslocando valores passados
obj.pSC.F = obj.pPar.Atuador.Cf*obj.pSC.W.^2;
obj.pSC.dF = (obj.pSC.F-obj.pSC.Fa)/obj.pTempo.Ts;

% Utilizando modelo de Euler-Lagrange
obj.pSC.Fa = obj.pSC.F;
obj.pPos.Xa = obj.pPos.X;

Rx = [1 0 0; 0 cos(obj.pPos.X(4)) -sin(obj.pPos.X(4)); 0 sin(obj.pPos.X(4)) cos(obj.pPos.X(4))];
Ry = [cos(obj.pPos.X(5)) 0 sin(obj.pPos.X(5)); 0 1 0; -sin(obj.pPos.X(5)) 0 cos(obj.pPos.X(5))];
Rz = [cos(obj.pPos.X(6)) -sin(obj.pPos.X(6)) 0; sin(obj.pPos.X(6)) cos(obj.pPos.X(6)) 0; 0 0 1];

R = Rz*Ry*Rx;

% W = [1 0 -sin(obj.pPos.X(5)); 0 cos(obj.pPos.X(4)) sin(obj.pPos.X(4))*cos(obj.pPos.X(5)); 0 -sin(obj.pPos.X(4)) cos(obj.pPos.X(4))*cos(obj.pPos.X(5))];

% =========================================================================
% Obtendo a postura do helicóptero
% Matriz de inércia translacional
Mt = obj.pPar.Corpo.m*eye(3,3);

% Vetor de forças gravitacionais
G = [0; 0; obj.pPar.Corpo.m*obj.pPar.Corpo.g];

% ArDrone
At = [0 0 0 0; 0 0 0 0; 1 1 1 1];

% Vetor de distúrbios adicionado ao vetor de forças que atuam no veículo
ft = R*At*obj.pSC.F - obj.pSC.D;

% Integracao númerica paras velocides cartesianas
obj.pPos.X(7:9) = Mt\(ft - G)*obj.pTempo.Ts + obj.pPos.X(7:9);

% =========================================================================
% Matriz de inércia rotacional
Mr = [obj.pPar.Corpo.Ixx, ...
    obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4)) - obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4)), ...
    -obj.pPar.Corpo.Ixx*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*cos(obj.pPos.X(5));
    
    obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4)) - obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4)), ...
    obj.pPar.Corpo.Iyy*cos(obj.pPos.X(4))^2 + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))^2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4)),...
    obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4))*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5));
    
    -obj.pPar.Corpo.Ixx*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*cos(obj.pPos.X(5)), ...
    obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4))*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5)),...
    obj.pPar.Corpo.Ixx*sin(obj.pPos.X(5))^2 + obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2 - 2*obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - 2*obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2
    ];

% Matriz de Coriolis e Forças Centrífugas rotacional
Cr = [ 0, ...
    obj.pPos.X(11)*(obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4)) + obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2 - obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2) + obj.pPos.X(12)*(-obj.pPar.Corpo.Ixx*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Iyy*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5)) - obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) + 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))),...
    obj.pPos.X(11)*(-obj.pPar.Corpo.Ixx*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Iyy*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5)) - obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) + 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))) + obj.pPos.X(12)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2);
    
    obj.pPos.X(10)*(-obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4)) - obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))) + obj.pPos.X(11)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4)) + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2 + obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2) + obj.pPos.X(12)*(obj.pPar.Corpo.Ixx*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))),...
    obj.pPos.X(10)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4)) + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2 + obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2),...
    obj.pPos.X(10)*(obj.pPar.Corpo.Ixx*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))) + obj.pPos.X(12)*(-obj.pPar.Corpo.Ixx*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5))^2 + obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))^2 + 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)));
    
    obj.pPos.X(10)*(obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4))*cos(obj.pPos.X(5))) + obj.pPos.X(11)*(-obj.pPar.Corpo.Ixx*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))) + obj.pPos.X(12)*(obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2),...
    obj.pPos.X(10)*(-obj.pPar.Corpo.Ixx*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))/2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))) + obj.pPos.X(11)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) + obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*sin(obj.pPos.X(5)) - obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2*sin(obj.pPos.X(5)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2*sin(obj.pPos.X(5))) + obj.pPos.X(12)*(obj.pPar.Corpo.Ixx*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5))^2 - obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))^2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5))),...
    obj.pPos.X(10)*(obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Izz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Ixy*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) + obj.pPar.Corpo.Iyz*cos(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2 - obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))^2*cos(obj.pPos.X(5))^2) + obj.pPos.X(11)*(obj.pPar.Corpo.Ixx*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Iyy*sin(obj.pPos.X(4))^2*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Izz*cos(obj.pPos.X(4))^2*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)) - obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.X(4))*sin(obj.pPos.X(5))^2 - obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*cos(obj.pPos.X(5))^2 + obj.pPar.Corpo.Ixz*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))^2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.X(4))*cos(obj.pPos.X(4))*sin(obj.pPos.X(5))*cos(obj.pPos.X(5)))
    ];

% Matriz de acoplamento rotacional

% ArDrone
Ar = [obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1 -obj.pPar.Propulsor.k1  -obj.pPar.Propulsor.k1;
    -obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1  -obj.pPar.Propulsor.k1;
    obj.pPar.Propulsor.k2 -obj.pPar.Propulsor.k2  obj.pPar.Propulsor.k2  -obj.pPar.Propulsor.k2];

% Momento devido ao arraste aerodinâmico das pás do rotor
T = Ar*obj.pSC.F - obj.pSC.Q;

%--------------------------------------------
% Integração discreta do movimento de rotação
obj.pPos.X(10:12) = Mr\(T - Cr*obj.pPos.X(10:12))*obj.pTempo.Ts + obj.pPos.X(10:12);

% Postura do ArDrone - Integracao discreta
for ii = 1:6
    obj.pPos.X(ii) = obj.pPos.X(ii+6)*obj.pTempo.Ts + obj.pPos.X(ii);
    if ii > 3
        if obj.pPos.X(ii) > pi
            obj.pPos.X(ii) = -2*pi + obj.pPos.X(ii);
        end
        if obj.pPos.X(ii) < -pi
            obj.pPos.X(ii) = 2*pi + obj.pPos.X(ii);
        end
    end
end

% Velocidade angular do veiculo com respeito ao proprio sistema de
% referencia do ArDrone
obj.pPos.Y = [1 0 -sin(obj.pPos.X(5));
    0 cos(obj.pPos.X(4)) sin(obj.pPos.X(4))*cos(obj.pPos.X(5));
    0 -sin(obj.pPos.X(4)) cos(obj.pPos.X(4))*cos(obj.pPos.X(5))]*obj.pPos.X(10:12);

if obj.pPos.X(3) < 0
    obj.pPos.X(3) = 0;
end
obj.pPos.dX = (obj.pPos.X - obj.pPos.Xa)/obj.pTempo.Ts;

end