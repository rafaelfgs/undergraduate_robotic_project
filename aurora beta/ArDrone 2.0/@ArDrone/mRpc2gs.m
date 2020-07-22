function mRpc2gs(obj)

% Enviar dados do PC que controla o ArDrone para a Ground Station

% Transmissão dos dados
fprintf(obj.pUDP.Pc2Pc.Com,['PC' num2str(obj.pPos.X') 'GS']);

% Recepção dos dados
if get(obj.pUDP.Pc2Pc.Com,'BytesAvailable') > 15   
    dadoLeitura = fscanf(obj.pUDP.Pc2Pc.Com,['GS %f%f%f%f%f%f%f%f%f%f%f%f PC' 10]);
    if size(dadoLeitura,1) == 12        
        obj.pPos.Xd = dadoLeitura;
        flushinput(obj.pUDP.Pc2Pc.Com)
    end
end
end