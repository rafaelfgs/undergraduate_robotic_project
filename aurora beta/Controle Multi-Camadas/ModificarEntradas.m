function [x,y,nMod] = ModificarEntradas(x,xd,y,yd)
%axis([-5 5 -5 5])

n = length(x);
nMod = 0;

for ii = 1:n
    tx(ii) = text(x(ii),y(ii),['X_{' num2str(ii) '}']);
end

for ii = 1:n
    h(ii) = plot([x(ii) xd(ii)],[y(ii) yd(ii)]);
end
% Calcular as distâncias
for ii = 1:n-1
    for jj = ii+1:n
        % Distância na configuração atual
        da1 = norm([xd(ii)-x(ii), yd(ii)-y(ii)]);
        da2 = norm([xd(jj)-x(jj), yd(jj)-y(jj)]);
        
        % Distância cruzada
        dc1 = norm([xd(ii)-x(jj), yd(ii)-y(jj)]);
        dc2 = norm([xd(jj)-x(ii), yd(jj)-y(ii)]);
        
        % efetuar troca
        if (da1+da2) > (dc1+dc2)
            nMod = nMod + 1;
            disp(['entrou: ' num2str([ii jj])])
            
            x_aux = x(ii);
            y_aux = y(ii);
            
            x(ii) = x(jj);
            y(ii) = y(jj);
            
            x(jj) = x_aux;
            y(jj) = y_aux;
            
            delete(h,tx)
            for kk = 1:n
                h(kk) = plot([x(kk) xd(kk)],[y(kk) yd(kk)],'k');
                tx(kk) = text(x(kk),y(kk),['X_{' num2str(kk) '}']);
            end
            drawnow
            pause(0.1)
        end        
    end
end
delete(h,tx)