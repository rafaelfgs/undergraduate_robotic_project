function mRFecharComunicacao(obj)

% Fechar Comunica��o
fclose(obj.pUDP.Pc2Pc.Com);
disp('Comunica��o PC-PC fechada')