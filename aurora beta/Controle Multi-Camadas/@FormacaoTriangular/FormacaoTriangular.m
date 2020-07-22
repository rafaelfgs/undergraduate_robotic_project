classdef FormacaoTriangular < handle
    % Formação Triangular arma a formação para a navegação
    % Para definir a formação é necessário saber quais são os robôs que a
    % compõem e quais são as variáveis desejadas de posição e de forma
    % do triângulo
    
    properties (SetAccess = private)
    end
    
    properties (SetAccess = public)
        pPos
        pSC
        pCAD
    end
    
    % Define an event called InsufficientFunds
    events
        
    end
    
    methods
        function Formacao = FormacaoTriangular()
            mIniFormacao(Formacao);
            mCADmake(Formacao);
            mCADplot(Formacao);
        end
        
        % =================================================================
        mIniFormacao(Formacao) 
        mTransformacaoDireta(Formacao,cOUd);
        mJacobianoDireto(Formacao,cOUd);
        
        mTransformacaoInversa(Formacao,cOUd);
        mJacobianoInverso(Formacao);
        
        mControleFormacaoTriangular(Formacao);
        
        % =================================================================
        mAtribuirRobos2Formacao(Formacao,Robos,cOUd);
        Robos = mAtribuirFormacao2Robos(Formacao,Robos);
        
        % =================================================================
        mCADmake(Formacao);
        mCADplot(Formacao);
    end
end