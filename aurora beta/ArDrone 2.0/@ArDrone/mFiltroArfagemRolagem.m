function mFiltroArfagemRolagem(obj)

%%%%% KALMAN_FILTER %%%%%
%%%%% Filtro de Kalman una dimension

% Onde: 
%		Xobs  - valor observado
%		Ypred - valor da predição
%
%		VARW - variância do sistema
%		VARN - variância da observação
%		MSE  - erro médio quadrático

% Gerando variavel observada
% Calculo do ganho de inovacao
GanhoK = (obj.pPar.Filtro.MSE + obj.pPar.Filtro.VARN)\obj.pPar.Filtro.MSE;

% Predicao
obj.pPar.Filtro.Ypred = obj.pPar.Filtro.Ypred + GanhoK*(obj.pPos.Xd(4:5) - obj.pPar.Filtro.Ypred);

% Estimacao do erro medio quadratico
obj.pPar.Filtro.MSE = (eye(2)-GanhoK)*obj.pPar.Filtro.MSE + obj.pPar.Filtro.VARW;

% Atruibuição
obj.pPos.Xd(4:5) = obj.pPar.Filtro.Ypred;


% Xbar = AX + BU
% Pbar = APA' + Q
% K = Pbar*H'*inv(H*Pbar*H'+R)
% X = Xbar + K*(Z-H*Xbar)
% P = Pbar-K*H*Pbar
