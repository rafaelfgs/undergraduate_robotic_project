function mRgs2pc(obj)

% Enviar dados do PC que controla o ArDrone para a Ground Station

% Transmissão dos dados
fprintf(obj.pUDP.Pc2Pc.Com,['GS' num2str(obj.pPos.Xd') 'PC']);

% Recepção dos dados
if get(obj.pUDP.Pc2Pc.Com,'BytesAvailable') > 15
    dadoLeitura = fscanf(obj.pUDP.Pc2Pc.Com,['PC %f%f%f%f%f%f%f%f%f%f%f%f GS' 10]);
    if size(dadoLeitura,1) == 12        
        obj.pPos.X = dadoLeitura;
        flushinput(obj.pUDP.Pc2Pc.Com)
    end
end
end