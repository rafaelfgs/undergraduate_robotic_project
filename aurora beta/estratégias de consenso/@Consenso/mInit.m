function mInit(obj)
% Vari�veis de Forma��o
obj.pVF.X    = zeros(12,1); % Postura dos rob�s
obj.pVF.SC   = [];          % Sinal de controle Global
obj.pVF.Ei   = zeros(3,1);  % Estado de informa��o corrente
obj.pVF.Eid  = zeros(3,1);  % Estado de informa��o desejado
obj.pVF.dEi  = zeros(3,1);  % Derivada do estado de informa��o corrente
obj.pVF.dEid = zeros(3,1);  % Valor de refer�ncia para a equa��o de consenso
obj.pVF.Madj = [];          % Matriz de adjac�ncia
obj.pVF.ID   = 0;           % Identifica��o do rob�
obj.pVF.nID  = 0;           % N�mero de rob�s

obj.pVF.Xd   = zeros(3,1);  % Valores de refer�ncia a serem adotados
obj.pVF.dXd  = zeros(3,1);  % como posi��o e velocidade do rob�

obj.pVF.XF   = zeros(3,1);  % Forma��o desejada ou ponto de encontro

%Vari�veis de Comunica��o
% obj.pVC.Conexoes = 0;      % Comunica��o com a rede UDP para buscar
                            % dados com os demais rob�s (Abertura portas de
                            % comunica��o)
                            
obj.pVC.ConexoesFlag = 0;  % Flag de comunica��o: 0 - Simula��o, 1 - Experimento                            
                            

                       
end