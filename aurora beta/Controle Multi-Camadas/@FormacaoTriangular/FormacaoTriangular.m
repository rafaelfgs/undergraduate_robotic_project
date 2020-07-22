classdef FormacaoTriangular < handle
    % Forma��o Triangular arma a forma��o para a navega��o
    % Para definir a forma��o � necess�rio saber quais s�o os rob�s que a
    % comp�em e quais s�o as vari�veis desejadas de posi��o e de forma
    % do tri�ngulo
    
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