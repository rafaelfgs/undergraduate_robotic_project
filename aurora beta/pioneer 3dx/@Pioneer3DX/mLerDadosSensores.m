function mLerDadosSensores(obj)

if obj.pStatus.Conectado
    
    % Posição do centro do robô
    obj.pPos.Xc(1) = arrobot_getx/1000;
    obj.pPos.Xc(2) = arrobot_gety/1000;
    obj.pPos.Xc(6) = arrobot_getth/180*pi;
    
    obj.pSC.U(1) = arrobot_getvel/1000;
    obj.pSC.U(2) = arrobot_getrotvel/180*pi;
    
    % Posição de controle do robôs
    obj.pPos.Xs([1 2 3]) = obj.pPos.Xc([1 2 3]) + [obj.pPar.a*cos(obj.pPos.Xc(6)); obj.pPar.a*sin(obj.pPos.Xc(6)); 0];
    obj.pPos.Xs([4 5 6]) = obj.pPos.Xc([4 5 6]); 
    
else
    obj.pPos.Xs = obj.pPos.X;
    
    % Posição do centro do robôs
    obj.pPos.Xc([1 2 6]) = obj.pPos.X([1 2 6]) - [obj.pPar.a*cos(obj.pPos.Xs(6)); obj.pPar.a*sin(obj.pPos.Xs(6)); 0];   
    
end

