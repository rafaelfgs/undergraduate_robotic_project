clear
close all
clc
try
    fclose(instrfindall)
end

addpath(genpath(pwd))

% Armazenar Dados Simulação
cd('!Arquivo de Dados Simulação')
ArqDados = fopen([datestr(clock,30) '.txt'],'w');
cd ..

% Identificar o computador q rodou a simulação
!hostname > hostname.txt
host = textread('hostname.txt','%s');
fprintf(ArqDados, '%s\r\n', host{1});
delete('hostname.txt');

figure
axis([-3 3 -3 3])
hold on

% Matriz de adjacência dos robôs
Madj = [0 0 0 0 0; 
        1 0 10 10 10; 
        1 0 0 10 10; 
        1 0 10 0 10; 
        1 0 10 10 0];

% Madj = [0 0 0 0 0; 
%         10 0 0 0 0; 
%         0 10 0 0 0; 
%         0 0 50 0 0; 
%         0 0 0 50 0];

% Criar objetos
for ii = 1:length(Madj)
    P{ii} = Pioneer3DX;
    P{ii}.pID = ii;
    P{ii}.pCAD.CockpitColor = bin2dec(dec2bin(ii,3)')';
end

C = Consenso;


% Atribuir no consenso a matriz adjacência
mMatrizAdjacenciaAtribuir(C,Madj);

%Setar Postura inicial
P{1}.pPos.Xso([1 2 6]) = [ginput(1) 0]';
P{2}.pPos.Xso([1 2 6]) = [ginput(1) 0]';
P{3}.pPos.Xso([1 2 6]) = [ginput(1) pi]';
P{4}.pPos.Xso([1 2 6]) = [ginput(1) -pi/2]';
P{5}.pPos.Xso([1 2 6]) = [ginput(1) pi/2]';

for ii = 1:length(P)
    P{ii}.mDefinirPosturaInicial(P{ii}.pPos.Xso([1 2 6]));
    %Ler postura inicial (lê obj.pPos.Xs)
    P{ii}.mLerDadosSensores;
    P{ii}.pPos.X = P{ii}.pPos.Xs;
    Rastro{ii} = P{ii}.pPos.X(1:2)*ones(1,200);
end

% Formação desejada baseada no consenso
aa = 1;
C.pVF.XF = [0 0 0; 
            1 0 0 ; 
            0 1 0; 
           -1 0 0; 
           0 -1 0]'*aa;

X = [];


tc = tic;
tc2 = tic;
t = tic;
tp = tic;
tei = tic;


while toc(t) < 180
    
    % Malha controle consenso

    % Malha controle robô
    if toc(tc) >= 0.1
        tc = tic;
        tempoPassado = toc(t);
        %Enviar informações do Pioneer
         for ii = 1:length(Madj)
            if ii == 1 && toc(t) < 170
                P{ii}.pPos.X(1) = sin(2*pi*0.015*toc(t));
                P{ii}.pPos.X(2) = sin(4*pi*0.015*toc(t));
                P{ii}.pPos.X(7) = 2*pi*0.015*sin(2*pi*0.015*toc(t));
                P{ii}.pPos.X(8) = 4*pi*0.015*sin(4*pi*0.015*toc(t));
            end
            
            %Adquirir Informações da Rede
            C.mEstadoInformacaoPopular(P{ii});
         end
        
        for ii = 1:length(Madj)
%             if ii == 1 && toc(t) < 50
%                 P{ii}.pPos.X(1) = sin(2*pi*0.025*toc(t));
%                 P{ii}.pPos.X(2) = sin(4*pi*0.025*toc(t));
%                 P{ii}.pPos.X(7) = 2*pi*0.025*sin(2*pi*0.025*toc(t));
%                 P{ii}.pPos.X(8) = 4*pi*0.025*sin(4*pi*0.025*toc(t));
%             end
%             
% %             Adquirir Informações da Rede
%             C.mEstadoInformacaoPopular(P{ii});
            
            %Setar postura inicial / Ler postura inicial (lê obj.pPos.Xs)
           
            P{ii}.mLerDadosSensores;
            P{ii}.pPos.X = P{ii}.pPos.Xs;
            
            %Atualizar os robôs com os dados adquiridos por consenso
            P{ii} = C.mEstadoInformacaoAtualizar(P{ii});
            
            %Calcular os sinais de controle com os dados atualizados
            P{ii} = fControladorPosicao(P{ii});
            
            %Enviar sinais de controle para o robô
            P{ii}.mEnviarSinaisControle;
            
            % Rastro Navegação
            Rastro{ii} = [Rastro{ii}(:,2:end) P{ii}.pPos.X(1:2)];
        end
        
        %disp(C.pVF.Ei)
        
        X = [X [C.pVF.Eid; C.pVF.dEid]];
        
        % Armazenar Dados Simulação
        fprintf(ArqDados,'%6.6f\t',tempoPassado);
        for kk = 1:C.pVF.nID
            fprintf(ArqDados,'%6.06f\t',C.pVF.X(:,kk)');
            fprintf(ArqDados,'%6.06f\t',C.pVF.SC(:,kk)');
        end
        fprintf(ArqDados,'\r\n');
        
       
    end
    
    if toc(tp) > 0.2
        tp = tic;
        try
            delete(h1)
            delete(h2)
            delete(h3)
        end
        for ii = 1:length(Madj)
            if ii ~= 1
                P{ii}.mCADdel
                P{ii}.mCADplot2D(P{ii}.pCAD.CockpitColor)
%                 P{ii}.mCADplot;
            else
                h1(1) = plot(P{ii}.pPos.X(1),P{ii}.pPos.X(2),'o','markersize',5,'Color',P{ii}.pCAD.CockpitColor);
            end
            h2(ii) = plot(Rastro{ii}(1,:),Rastro{ii}(2,:),'Color',P{ii}.pCAD.CockpitColor,'LineStyle','--');            
        end
        h1(2) = plot([C.pVF.X(1,2:end) C.pVF.X(1,2)],[C.pVF.X(2,2:end) C.pVF.X(2,2)]);
        x1  = [C.pVF.X(1,2:end) C.pVF.X(1,2)]';
        y1 = [C.pVF.X(2,2:end) C.pVF.X(2,2)]';
        
        disp(['area: ' num2str(2*area(alphaShape(x1(1:4),y1(1:4),2.5)))]);
        
        x = P{1}.pPos.X(1)+[1; 0; -1; 0; 1]*aa;
        y = P{1}.pPos.X(2)+[0; 1; 0; -1; 0]*aa;     
        h3 = plot(x, y, 'b--'); 
        drawnow
    end
    
end

fclose(ArqDados);

