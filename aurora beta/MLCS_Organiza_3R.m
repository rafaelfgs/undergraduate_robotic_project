% Teste cooperação de N-robôs

clear all
close all
clc

addpath(genpath(pwd))

ExibirSimulacao = 1;

% Número de robôs da formação
R{1} = ArDrone;
R{2} = ArDrone;
R{3} = ArDrone;

R{1}.mCADcolor([0.8 0.8 0]);
R{2}.mCADcolor([0 0.6 0]);
R{3}.mCADcolor([0 0 0.6]);

% =========================================================================
% Definir posição inicial e desejada dos robôs
figure(1);
cameratoolbar
hold on
% Ambiente
ambTeste = imread('drenantecinza.jpg');
[X, Y] = meshgrid(-2:2,-2:2);
Z = zeros(size(X));
surf(X,Y,Z, ambTeste, 'edgecolor', 'none','FaceColor','texturemap','FaceAlpha',0.5)
%set(gcf,'renderer','opengl');
axis([-2 2 -2 2])

for ii = 1:length(R)
    R{ii}.pPos.X(1:3,1) = [ginput(1)';0];
    R{ii}.mCADplot;
end
axis([-2 2 -2 2 0 2])
axis equal
view(-30,15)
% =========================================================================
% Declarando Formação
FT = FormacaoTriangular([0 0 1 0 0 0 1 1 pi/4]','f');

a = [];
t.laco = tic;
t.atual = tic;
t.plotar = tic;
t.tmax = 30;

while toc(t.atual) < t.tmax       
    
    % Controle de Formação
    mAtribuirRobos2Formacao(FT,R);
    mControleFormacaoTriangular(FT);    
    R = mAtribuirFormacao2Robos(FT,R);    
    
    for ii = 1:length(R)
        if mPermissaoExecucao(R{ii})
            R{ii}.mLerDadosSensores;
            R{ii}.mControladorSubatuado;
            R{ii}.mEnviarSinaisControle;           
        end
    end
    
    if toc(t.plotar) > 0.15 && ExibirSimulacao
        t.plotar = tic;
        for ii = 1:length(R)
            mCADplot(R{ii})
        end
        mCADplot(FT)
        
        drawnow
    end
    
    a = [a toc(t.laco)];
    t.laco = tic;
end
