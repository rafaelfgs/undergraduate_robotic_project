function mCalibrarSensores(obj)

if obj.pStatus.Conectado
    disp('Calibração dos sensores de orientação')
    t = tic;
    ts = tic;
    
    Ang = [];
    
    while toc(t) < 3
        if toc(ts) > 1/30
            ts = tic;
            % Associando dados dos sensores obtidos pela NavData
            Ang = [Ang [1 0 0; 0 -1 0; 0 0 -1]*obj.pDados.SensorRaw(2:4)*pi/180];
        end
    end
    
    media = mean(Ang,2);
    obj.pPos.Ximuo(6,1) = media(3);
    disp('Fim da calibração')
end
end