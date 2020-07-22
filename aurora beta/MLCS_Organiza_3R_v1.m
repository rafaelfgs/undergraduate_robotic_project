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
    R{ii}.pPos.Xd(1:3,1) = [ginput(1)';1];
    R{ii}.mCADplotD('on');
end

for ii = 1:length(R)
    R{ii}.pPos.X(1:3,1) = [ginput(1)';0];
    R{ii}.mCADplot('on');
end

[R{1}.pPos.Xd(1:3,1) R{2}.pPos.Xd(1:3,1) R{3}.pPos.Xd(1:3,1)]

% break
axis([-2 2 -2 2 0 2])
axis equal

% =========================================================================
% Declarando Formação
FT = FormacaoTriangular;
mAtribuirRobos2Formacao(FT,R,'d');
mTransformacaoDireta(FT,'d');
mCADplot(FT)
%mTransformacaoInversa(FT,'d');

reshape(FT.pPos.xd,3,3)

mAtribuirRobos2Formacao(FT,R,'c');
mTransformacaoDireta(FT,'c');
%mTransformacaoInversa(FT,'c');
mCADplot(FT)
% =========================================================================
% Efetuar a organização automática
view(0,90)
R = mPermutaPosicoes(R);
view(-30,15)
pause(5)

a = [];
t.laco = tic;
t.atual = tic;
t.plotar = tic;
t.tmax = 30;

k = 0;
while toc(t.atual) < t.tmax       
    
    % Controle de Formação
    mAtribuirRobos2Formacao(FT,R,'c');
    mTransformacaoDireta(FT,'c');
    
    mControleFormacaoTriangular(FT);   
    
    mJacobianoInverso(FT);
    mTransformacaoInversa(FT,'d');    
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
    k = k + 1;
end