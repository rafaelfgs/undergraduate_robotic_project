function robo = fControladorPosicao(robo)

Kp1 = [1,0;0,1]*.5;
Kp2 = [1,0;0,1]*.5;

robo.pPos.X = robo.pPos.Xs;
K = [ cos(robo.pPos.X(6)), -robo.pPar.a*sin(robo.pPos.X(6)); ...
    sin(robo.pPos.X(6)), +robo.pPar.a*cos(robo.pPos.X(6))];

% Saturação da derivada desejada da postura
if abs(robo.pPos.dXd(1)) > 0.1
    robo.pPos.dXd(1) = sign(robo.pPos.dXd(1))*0.1;
end

if abs(robo.pPos.dXd(2)) > 0.1
    robo.pPos.dXd(2) = sign(robo.pPos.dXd(2))*0.1;
end

robo.pPos.Xtil = robo.pPos.Xd - robo.pPos.X; 

% if abs(robo.pPos.Xtil) < 0.05
%     robo.pPos.Xtil = robo.pPos.Xd - robo.pPos.Xd;
% end

robo.pSC.Ur = K\(robo.pPos.dXd(1:2) + Kp1*tanh(Kp2*robo.pPos.Xtil(1:2)) );
% if abs(robo.pSC.Ur(2)) > .3
%     robo.pSC.Ur(2) = sign(robo.pSC.Ur(2))*.3;
% end

