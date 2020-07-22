function mLerDadosSensores(obj)

obj.pPos.Xsa = obj.pPos.Xs;

if obj.pStatus.Conectado
    
    % Associando dados dos sensores obtidos pela NavData
    obj.pPos.Xs(3) = obj.pDados.SensorRaw(1);
    
    obj.pPos.Xs(4:6) = [1 0 0; 0 -1 0; 0 0 -1]*obj.pDados.SensorRaw(2:4)*pi/180;
    
    % Definir guinada igual a zero independente da orientação global do
    % AR.Drone
    obj.pPos.Xs(4:6) = obj.pPos.Xs(4:6) - obj.pPos.Xso(4:6);
    if obj.pPos.Xs(6) > pi
        obj.pPos.Xs(6) = obj.pPos.Xs(6) - 2*pi;
    end
    if obj.pPos.Xs(6) < -pi
        obj.pPos.Xs(6) = obj.pPos.Xs(6) + 2*pi;
    end
    
    % Matriz de rotação
    Rx = [1 0 0; 0 cos(obj.pPos.Xs(4)) -sin(obj.pPos.Xs(4)); 0 sin(obj.pPos.Xs(4)) cos(obj.pPos.Xs(4))];
    Ry = [cos(obj.pPos.Xs(5)) 0 sin(obj.pPos.Xs(5)); 0 1 0; -sin(obj.pPos.Xs(5)) 0 cos(obj.pPos.Xs(5))];
    Rz = [cos(obj.pPos.Xs(6)) -sin(obj.pPos.Xs(6)) 0; sin(obj.pPos.Xs(6)) cos(obj.pPos.Xs(6)) 0; 0 0 1];
    
    R = Rz*Ry*Rx;
    
    obj.pPos.Xs(7:9)   = R*[1 0 0; 0 -1 0; 0 0 -1]*obj.pDados.SensorRaw(5:7); % Conversão NED para XYZ
    
    obj.pPos.Xs(10:12) = [1 0 0; 0 -1 0; 0 0 -1]*obj.pDados.SensorRaw(11:13)*pi/180;
    
    % Integração numérica da posição
    obj.pPos.Xs(1:3)   = obj.pPos.Xs(7:9)*obj.pTempo.Ts + obj.pPos.Xs(1:3);
    
else    
    obj.pPos.Xs = obj.pPos.X;
%     obj.pPos.Xs(4) = obj.pPos.Xs(4) + 0.01*randn(1);
%     obj.pPos.Xs(5) = obj.pPos.Xs(5) + 0.01*randn(1);
%     obj.pPos.Xs = obj.pPos.Xs + 0.01*randn(size(obj.pPos.Xs));
end