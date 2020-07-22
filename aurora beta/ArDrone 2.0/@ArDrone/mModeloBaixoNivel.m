function mModeloBaixoNivel(obj)

% Matriz de rotação
Rx = [1 0 0; 0 cos(obj.pPos.Xs(4)) -sin(obj.pPos.Xs(4)); 0 sin(obj.pPos.Xs(4)) cos(obj.pPos.Xs(4))];
Ry = [cos(obj.pPos.Xs(5)) 0 sin(obj.pPos.Xs(5)); 0 1 0; -sin(obj.pPos.Xs(5)) 0 cos(obj.pPos.Xs(5))];
Rz = [cos(obj.pPos.Xs(6)) -sin(obj.pPos.Xs(6)) 0; sin(obj.pPos.Xs(6)) cos(obj.pPos.Xs(6)) 0; 0 0 1];

R = Rz*Ry*Rx;

% Matriz de Acoplamento e Matriz dos Braços de Forcas
% [F1 F2 F3]' = R*At*[fx fy fz fytr]'
At = R*[0 0 0 0; 0 0 0 0; 1 1 1 1];

% [L M N]' = Ar*[fx fy fz fytr]'
Ar = [obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1 -obj.pPar.Propulsor.k1  -obj.pPar.Propulsor.k1;
    -obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1  -obj.pPar.Propulsor.k1;
    obj.pPar.Propulsor.k2 -obj.pPar.Propulsor.k2  obj.pPar.Propulsor.k2  -obj.pPar.Propulsor.k2];

A = [At;Ar];

% Matriz Pseudo-Inversa de A
As = pinv(A); %(A'*A)\A';

% Verificando se forças sobre o referência do veículo
% ocrrem somente na direção Z
% obj.pSC.fTau = A*obj.pSC.Fr;

% ------------------------------------
% Forçando valores possíveis: 30% do valor da gravidade
if real(obj.pSC.fTau(3)) < 0
    obj.pSC.fTau(3) = obj.pPar.Corpo.m*obj.pPar.Corpo.g*0.3;
end
% obj.pSC.fTau(1) = 0;
% obj.pSC.fTau(2) = 0;
% ------------------------------------

% Considerando a situação mais simples de que a força de propulsão
% solicitada aos motores é imediatamente atendida

% Modelo Inverso do Atuador
obj.pSC.Fr = As*obj.pSC.fTau;

% Caso a força do propulsor seja negativa, assume-se propulsão igual a zero
for ii = 1:4
    if obj.pSC.Fr(ii) < 0
        obj.pSC.Fr(ii) = 0;
    end
end

% 1: Fr -> Wr
obj.pSC.Wra = obj.pSC.Wr;
obj.pSC.Wr = sqrt(obj.pSC.Fr/obj.pPar.Atuador.Cf);


% 2: Wr -> V % -8.65*ones(4,1)
% obj.Vo = 1/obj.Atuador.Km*((obj.Atuador.Bm*obj.Atuador.R+obj.Atuador.Km*obj.Atuador.Kb)*sqrt(obj.Parametros.m*obj.Parametros.g/4/obj.Atuador.Cf) + obj.Atuador.R*obj.Atuador.Ct*obj.Parametros.m*obj.Parametros.g/4/obj.Atuador.Cf);
obj.pSC.Vo = (obj.pPar.Atuador.R*obj.pPar.Atuador.Bm/obj.pPar.Atuador.Km + obj.pPar.Atuador.Kb)*sqrt(obj.pPar.Corpo.m*obj.pPar.Corpo.g/4/obj.pPar.Atuador.Cf) + obj.pPar.Atuador.R*obj.pPar.Atuador.Ct/obj.pPar.Atuador.Km*obj.pPar.Corpo.m*obj.pPar.Corpo.g/4/obj.pPar.Atuador.Cf;

% obj.Vr = - obj.Vo + 1/obj.Atuador.Km*(obj.Atuador.Jm*obj.Atuador.R/obj.Ts*(obj.pSC.Wr-obj.pSC.Wr(:,obj.na-1)) + ...
%    (obj.Atuador.Bm*obj.Atuador.R+obj.Atuador.Km*obj.Atuador.Kb)*obj.pSC.Wr + obj.Atuador.R*obj.Atuador.Ct*obj.pSC.Wr.^2);
obj.pSC.Vr = - obj.pSC.Vo + obj.pPar.Atuador.R/obj.pPar.Atuador.Km*(obj.pPar.Atuador.Jm*(obj.pSC.Wr-obj.pSC.Wra)/obj.pTempo.Ts + ...
    (obj.pPar.Atuador.Bm+obj.pPar.Atuador.Km*obj.pPar.Atuador.Kb/obj.pPar.Atuador.R)*obj.pSC.Wr + obj.pPar.Atuador.Ct*obj.pSC.Wra.^2);

% 3: V -> Xr
obj.pPos.Xr(4) = obj.pPos.Xs(4) + 1/(obj.pPar.Atuador.kdp+obj.pPar.Atuador.kpp*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kdp*(obj.pPos.Xr(4)-obj.pPos.Xsa(4)) + 1/4*obj.pTempo.Ts*([1 1 -1 -1]*obj.pSC.Vr));

obj.pPos.Xr(5) = obj.pPos.Xs(5) + 1/(obj.pPar.Atuador.kdt+obj.pPar.Atuador.kpt*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kdt*(obj.pPos.Xr(5)-obj.pPos.Xsa(5)) + 1/4*obj.pTempo.Ts*([-1 1 1 -1]*obj.pSC.Vr));

obj.pPos.Xr(12) = obj.pPos.Xs(12) + 1/(obj.pPar.Atuador.kds+obj.pPar.Atuador.kps*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kds*(obj.pPos.Xr(12)-obj.pPos.Xsa(12)) + 1/4*obj.pTempo.Ts*([1 -1 1 -1]*obj.pSC.Vr));

obj.pPos.Xr(9) = obj.pPos.Xs(9) + 1/(obj.pPar.Atuador.kdz+obj.pPar.Atuador.kpz*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kdz*(obj.pPos.Xr(9)-obj.pPos.Xsa(9)) + 1/4*obj.pTempo.Ts*([1 1 1 1]*obj.pSC.Vr));

% Modelo inverso do Joystick
% Comandos de referência enviados pelo joystick
obj.pSC.Joystick.Ar(1) =  -obj.pPos.Xr(5)/obj.pPar.Joystick.AngMax;
obj.pSC.Joystick.Ar(2) =   obj.pPos.Xr(4)/obj.pPar.Joystick.AngMax;
obj.pSC.Joystick.Ar(3) =  -obj.pPos.Xr(12)/obj.pPar.Joystick.MaxRatePsi;
obj.pSC.Joystick.Ar(4) =   obj.pPos.Xr(9)/obj.pPar.Joystick.MaxRateZ;


for ii = 1:4
    if abs(obj.pSC.Joystick.Ar(ii)) > 1
        obj.pSC.Joystick.Ar(ii) = sign(obj.pSC.Joystick.Ar(ii));
    end
end

