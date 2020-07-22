function mREstabelecerComunicacao(obj)
% Inicia a transferência de dados entre o PC Principal e o PC do drone
% Status: 0 - Sem comunicação | 1 - Comunicando

tt = tic;
flag = zeros(3,1);

while 1
    if toc(tt) > obj.pTempo.Ts
        tt = tic;
        switch obj.pUDP.Pc2Pc.RxD
            case 'o'
                if flag(1) == 0
                    disp('Transmitindo...')
                    flag(1) = 1;
                end
                obj.pUDP.Pc2Pc.TxD = 'T';
                fprintf(obj.pUDP.Pc2Pc.Com,'T');
            case 'T'
                if flag(2) == 0
                    disp('Recebido')
                    flag(2) = 1;
                end
                obj.pUDP.Pc2Pc.TxD = 'R';
                fprintf(obj.pUDP.Pc2Pc.Com,'R');
            case 'R'
                if flag(3) == 0
                    disp('Estabelecendo...')
                    flag(3) = 1;
                end
                obj.pUDP.Pc2Pc.TxD = 'E';
                fprintf(obj.pUDP.Pc2Pc.Com,'E');
            case 'E'
                disp('Estabelecida')
                fprintf(obj.pUDP.Pc2Pc.Com,'E');
                flushinput(obj.pUDP.Pc2Pc.Com)
                break
        end
    end
    
    while get(obj.pUDP.Pc2Pc.Com,'BytesAvailable')
        dadoLeitura = fscanf(obj.pUDP.Pc2Pc.Com);
        if ~strcmp(obj.pUDP.Pc2Pc.RxD,dadoLeitura(1));
            obj.pUDP.Pc2Pc.RxD = dadoLeitura(1);
            break
        end
    end
end

end