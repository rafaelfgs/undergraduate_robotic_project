function [X,Xd,nMod] = PermutaPosicoes(X,Xd)

nMod = 0;
n = length(X);

% Calcular as distâncias
for ii = 1:n-1
    for jj = ii+1:n
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
            pause(2)
            delete(h)
            delete(tx)
            delete(txd)
        end        
    end
end
disp('-----')