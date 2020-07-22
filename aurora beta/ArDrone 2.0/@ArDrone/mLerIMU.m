function mLerIMU(obj)

obj.pPos.Ximua = obj.pPos.Ximu;

if obj.pStatus.Conectado
    
    % Realiza o teste se a rotina j� foi executada, caso positivo, ela ir�
    % salvar os dados lidos atrav�s da mSalvarDados
    if obj.pflag.SalvarXimu == 0
        obj.pflag.SalvarXimu = 1;
    end
    
    if obj.pflag.XimuOffset == 0
        obj.pflag.XimuOffset = 1;
        disp('Calibrando Sensores Internos....')
        mLerIMUOffset(obj);
    end
    
    % Associando dados dos sensores obtidos pela NavData
    obj.pPos.Ximu(3) = obj.pDados.SensorRaw(1);
    
    obj.pPos.Ximu(4:6) = [1 0 0; 0 -1 0; 0 0 -1]*obj.pDados.SensorRaw(2:4)*pi/180;
    
%     % Definir guinada igual a zero independente da orienta��o global do
%     % AR.Drone
%     obj.pPos.Ximu(4:6) = obj.pPos.Ximu(4:6) - obj.pPos.Ximuo(4:6);
%     if obj.pPos.Ximu(6) > pi
%         obj.pPos.Ximu(6) = obj.pPos.Ximu(6) - 2*pi;
%     end
%     if obj.pPos.Ximu(6) < -pi
%         obj.pPos.Ximu(6) = obj.pPos.Ximu(6) + 2*pi;
%     end
    
    % Matriz de rota��o
    Rx = [1 0 0; 0 cos(obj.pPos.Ximu(4)) -sin(obj.pPos.Ximu(4)); 0 sin(obj.pPos.Ximu(4)) cos(obj.pPos.Ximu(4))];
    Ry = [cos(obj.pPos.Ximu(5)) 0 sin(obj.pPos.Ximu(5)); 0 1 0; -sin(obj.pPos.Ximu(5)) 0 cos(obj.pPos.Ximu(5))];
    Rz = [cos(obj.pPos.Ximu(6)) -sin(obj.pPos.Ximu(6)) 0; sin(obj.pPos.Ximu(6)) cos(obj.pPos.Ximu(6)) 0; 0 0 1];
    
    R = Rz*Ry*Rx;
    
    obj.pPos.Ximu(7:9)   = R*[1 0 0; 0 -1 0; 0 0 -1]*obj.pDados.SensorRaw(5:7); % Convers�o NED para XYZ
    
    obj.pPos.Ximu(10:12) = [1 0 0; 0 -1 0; 0 0 -1]*obj.pDados.SensorRaw(11:13)*pi/180;
    
    % Integra��o num�rica da posi��o
    obj.pPos.Ximu(1:3)   = obj.pPos.Ximu(7:9)*obj.pTempo.Ts + obj.pPos.Ximu(1:3);        
else
    obj.pPos.Ximu = obj.pPos.X;
    %     obj.pPos.Ximu(4) = obj.pPos.Ximu(4) + 0.01*randn(1);
    %     obj.pPos.Ximu(5) = obj.pPos.Ximu(5) + 0.01*randn(1);
    %     obj.pPos.Ximu = obj.pPos.Ximu + 0.01*randn(size(obj.pPos.Ximu));
end