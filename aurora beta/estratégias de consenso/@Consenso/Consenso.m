classdef Consenso < handle
    % In a methods block, set the method attributes
    % and add the function signature
    properties
        pVF % Indica vari�veis de forma��o
        pVC % Indica vari�veis de comunica��o
        
        
    end
    
    methods
        function obj = Consenso
            mInit(obj);
        end
        
        mInit(obj);
        
        % Atribuir matriz de adjac�ncia
        mMatrizAdjacenciaAtribuir(obj,Madj);
        
        % Conjunto de fun��es para intera��o em consenso
        mConexoesCriar(obj);                         % Abertura de portas para buscar dados 
                                                     % dos demais rob�s.
        mEstadoInformacaoPopular(obj,robo);          % Adquirir dados dos rob�s atrav�s da rede
        robo = mEstadoInformacaoAtualizar(obj,robo); % Atualizar nos rob�s os dados adquiridos por consenso
        
        
        
    end
end