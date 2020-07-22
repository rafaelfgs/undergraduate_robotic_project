function [X,Y,Z,nMod] = ModificarEntradas3d(X,Xd,Y,Yd,Z,Zd)
%axis([-5 5 -5 5])

n = length(X);
nMod = 0;

for ii = 1:n
    tx(ii) = text(X(ii),Y(ii),['X_{' num2str(ii) '}']);
end

for ii = 1:n
    h(ii) = plot([X(ii) Yd(ii)],[Y(ii) Yd(ii)]);
end

% Calcular as distâncias
for ii = 1:n-1
    for jj = ii+1:n
        % Distância na configuração atual
        da1 = norm([Xd(ii)-X(ii), Yd(ii)-Y(ii), Zd(ii)-Z(ii)]);
        da2 = norm([Xd(jj)-X(jj), Yd(jj)-Y(jj), Zd(jj)-Z(jj)]);
        
        % Distância cruzada
        dc1 = norm([Xd(ii)-X(jj), Yd(ii)-Y(jj), Zd(ii)-Z(jj)]);
        dc2 = norm([Xd(jj)-X(ii), Yd(jj)-Y(ii), Zd(jj)-Z(ii)]);
        
        % efetuar troca
        if (da1+da2) > (dc1+dc2)
            nMod = nMod + 1;
            disp(['entrou: ' num2str([ii jj])])
            
            x_aux = X(ii);
            y_aux = Y(ii);
            z_aux = Z(ii);
            
            X(ii) = X(jj);
            Y(ii) = Y(jj);
            Z(ii) = Z(jj);
            
            X(jj) = x_aux;
            Y(jj) = y_aux;
            Z(jj) = z_aux;
          
            delete(h,tx)
            for kk = 1:n
                h(kk) = plot([X(kk) Xd(kk)],[Y(kk) Yd(kk)],'k');
                tx(kk) = text(X(kk),Y(kk),['X_{' num2str(kk) '}']);
            end
            drawnow
            pause(0.2)
        end        
    end
end
delete(h,tx)