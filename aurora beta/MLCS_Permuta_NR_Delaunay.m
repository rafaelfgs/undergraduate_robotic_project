% Permutação de N-robôs em função da posição inicial e desejada
clear all
close all
clc

addpath(genpath(pwd))

ExibirSimulacao = 1;

% Número de robôs da formação
R{1} = ArDrone;
R{2} = ArDrone;
R{3} = ArDrone;
R{4} = ArDrone;
R{5} = ArDrone;
R{6} = ArDrone;
R{7} = ArDrone;
R{8} = ArDrone;

R{1}.mCADcolor([0.8 0.8 0]);
R{2}.mCADcolor([0 0.6 0]);
R{3}.mCADcolor([0 0 0.6]);
R{4}.mCADcolor([0.6 0 0.6]);
R{5}.mCADcolor([0.6 0.6 0.6]);
R{6}.mCADcolor([0.3 0 0.8]);
R{7}.mCADcolor([0 0.3 0.8]);
R{8}.mCADcolor([0.8 0 0.3]);


% =========================================================================
% Definir posição inicial e desejada dos robôs
figure(1);
cameratoolbar
hold on
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

axis([-2 2 -2 2 0 2])
axis equal

% =========================================================================
% Efetuar a organização automática
view(0,90)
R = mPermutaPosicoes(R,1);
T = mCriaTriangulos(R);

% =========================================================================
% Declarando Formação X Triângulos
for ii = 1:size(T,1)
    F(ii) = FormacaoTriangular;
    mAtribuirRobos2Formacao(F(ii),R(T(ii,:)),'d');
    mTransformacaoDireta(F(ii),'d');
    
    mAtribuirRobos2Formacao(F(ii),R(T(ii,:)),'c');
    mTransformacaoDireta(F(ii),'c');
    
    mCADplot(F(ii))
end

pause(2)

% Ambiente
ambTeste = imread('drenantecinza.jpg');
[X, Y] = meshgrid(-2:2,-2:2);
Z = zeros(size(X));
surf(X,Y,Z, ambTeste, 'edgecolor', 'none','FaceColor','texturemap','FaceAlpha',0.5)
view(-30,15)

a = [];
t.laco = tic;
t.atual = tic;
t.plotar = tic;
t.tmax = 30;


k = 0;
while toc(t.atual) < t.tmax       
    
    for ii = 1:size(T,1)
        % Controle de Formação
        mAtribuirRobos2Formacao(F(ii),R(T(ii,:)),'c');
        mTransformacaoDireta(F(ii),'c');
        
        mControleFormacaoTriangular(F(ii));
        
        mJacobianoInverso(F(ii));
        mTransformacaoInversa(F(ii),'d');
        % R(T(ii,:)) = mAtribuirFormacao2Robos(F(ii),R(T(ii,:)));
    end
    
    R = mPonderaReferencias(F,T,R);
    
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
        
        for ii = 1:size(T,1)
            mCADplot(F(ii))
        end
        
        drawnow
    end
    
    a = [a toc(t.laco)];
    t.laco = tic;
    k = k + 1;
end