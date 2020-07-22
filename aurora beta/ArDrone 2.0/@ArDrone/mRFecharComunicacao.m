function mRFecharComunicacao(obj)

% Fechar Comunicação
fclose(obj.pUDP.Pc2Pc.Com);
disp('Comunicação PC-PC fechada')