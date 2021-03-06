function Robos = mPermutaPosicoes(Robos,tp)

n = length(Robos);
for kk = 1:n
    X(:,kk)  = Robos{kk}.pPos.X(1:3);
    Xd(:,kk) = Robos{kk}.pPos.Xd(1:3);
end

for kk = 1:n
    h(kk)   = plot([X(1,kk) Xd(1,kk)],[X(2,kk) Xd(2,kk)]);
    tx(kk)  = text(X(1,kk),X(2,kk),['X_{' num2str(kk) '}']);
    txd(kk) = text(Xd(1,kk),Xd(2,kk),['Xd_{' num2str(kk) '}']);
end

drawnow
pause(tp)
delete(h)
delete(tx)
delete(txd)

% Número de modificações
nMod = 0;

% Calcular as distâncias
for ii = 1:n
    for jj = 1:n
        if ii ~= jj
            % Distância na configuração atual
            da1 = norm(Xd(:,ii)-X(:,ii));
            da2 = norm(Xd(:,jj)-X(:,jj));
            
            % Distância cruzada
            dc1 = norm(Xd(:,ii)-X(:,jj));
            dc2 = norm(Xd(:,jj)-X(:,ii));
            
            % efetuar troca
            if (da1+da2) > (dc1+dc2)
                nMod = nMod + 1;
                disp(['entrou: ' num2str([ii jj])])
                
                X_aux = Xd(:,ii);
                Xd(:,ii) = Xd(:,jj);
                Xd(:,jj) = X_aux;
                
                for kk = 1:n
                    h(kk)   = plot([X(1,kk) Xd(1,kk)],[X(2,kk) Xd(2,kk)]);
                    tx(kk)  = text(X(1,kk),X(2,kk),['X_{' num2str(kk) '}']);
                    txd(kk) = text(Xd(1,kk),Xd(2,kk),['Xd_{' num2str(kk) '}']);
                end
                drawnow
                pause(tp)
                delete(h)
                delete(tx)
                delete(txd)
                
                
                Xd_aux = Robos{ii}.pPos.Xd;
                Robos{ii}.pPos.Xd = Robos{jj}.pPos.Xd;
                Robos{jj}.pPos.Xd = Xd_aux;
                
                Robos{ii}.mCADplotD('on');
                Robos{jj}.mCADplotD('on');
                
            end
        end
    end
end
disp('-----')

for kk = 1:n
    h(kk)   = plot([X(1,kk) Xd(1,kk)],[X(2,kk) Xd(2,kk)]);
    tx(kk)  = text(X(1,kk),X(2,kk),['X_{' num2str(kk) '}']);
    txd(kk) = text(Xd(1,kk),Xd(2,kk),['Xd_{' num2str(kk) '}']);
end
drawnow
pause(5)
delete(h)
delete(tx)
delete(txd)
end