function mCADmake(obj)

% Parâmetros físicos do Robô

N = 5;

%% Define vértices do robô
% Plano Superior
x = [-0.075 -0.025 0.26*cos(linspace(-pi/3,pi/3,N)) -0.025 -0.075 0.27*cos(linspace(3/4*pi,5/4*pi,N))];
y = [0.27*sin(5*pi/4) 0.26*sin(-pi/3) 0.26*sin(linspace(-pi/3,pi/3,N)) 0.26*sin(pi/3) 0.27*sin(3*pi/4)  0.27*sin(linspace(3/4*pi,5/4*pi,N))];
z = (0.05+0.215*ones(1,size(y,2)));
obj.pCAD.vertices{1} = [x; y; z];

% Suporte do Sonar
x =  [-0.075 -0.025 0.22*cos(linspace(-pi/3,pi/3,N)) -0.025 -0.075 0.23*cos(linspace(3/4*pi,5/4*pi,N))];
y =  [0.23*sin(5*pi/4) 0.22*sin(-pi/3) 0.22*sin(linspace(-pi/3,pi/3,N)) 0.22*sin(pi/3) 0.23*sin(3*pi/4)  0.23*sin(linspace(3/4*pi,5/4*pi,N))];
zt = (0.05 + 0.213*ones(1,size(y,2)));
zb = (0.05 + 0.155*ones(1,size(y,2)));
obj.pCAD.vertices{2} = [x;y;zt];
obj.pCAD.vertices{3} = [x;y;zb];

% Corpo
x = [-0.13 0.1 0.175 0.175 0.1 -0.13 -0.195 -0.195];
y = [0.15 0.15 0.1 -0.1 -0.15 -0.15 -0.1 0.1];
zt = (0.05 + 0.154*ones(1,size(y,2)));
zb = (0.05 + 0.05*ones(1,size(y,2)));
obj.pCAD.vertices{4} = [x;y;zt];
obj.pCAD.vertices{5} = [x;y;zb];

% Rodas

obj.pCAD.N_lados = 15;
for k=1:4
    obj.pCAD.rodas{k}(1,:) = 0.09*cos(linspace(-pi,pi,obj.pCAD.N_lados));
    obj.pCAD.rodas{k}(3,:) = (0.09 + .09*sin(linspace(-pi,pi,obj.pCAD.N_lados)));
end
obj.pCAD.rodas{1}(2,:) = -0.21*ones(1,obj.pCAD.N_lados);
obj.pCAD.rodas{2}(2,:) = -0.155*ones(1,obj.pCAD.N_lados);
obj.pCAD.rodas{3}(2,:) = 0.155*ones(1,obj.pCAD.N_lados);
obj.pCAD.rodas{4}(2,:) = 0.21*ones(1,obj.pCAD.N_lados);


% % Roda de apoio
% x = -0.195 + 0.057*cos(linspace(-pi,pi,obj.pCAD..N_lados));
% y = [-0.02 0.02];
% z = 0.03+ 0.057*sin(linspace(-pi,pi,obj.pCAD..N_lados));
% robo.roda_apoio = [x;y;z];

%% Preenche o robô

% Suporte superior do sonar /Suporte inferior do Sonar  (TB)
N1 = size(obj.pCAD.vertices{2},2);

for k=1:(N1-1)
    x = [obj.pCAD.vertices{2}(1,[k k+1]) obj.pCAD.vertices{3}(1,[k+1 k])];
    y = [obj.pCAD.vertices{2}(2,[k k+1]) obj.pCAD.vertices{3}(2,[k+1 k])];
    z = (0.05 + [0.213*ones(1,2) 0.155*ones(1,2)]);
    obj.pCAD.corpo{k} = [x;y;z];
end
obj.pCAD.corpo{N1} = [obj.pCAD.vertices{2}(1,[N1 1]) obj.pCAD.vertices{3}(1,[1 N1])
    obj.pCAD.vertices{2}(2,[N1 1]) obj.pCAD.vertices{3}(2,[1 N1])
    0.05+0.213*ones(1,2)       0.05+0.155*ones(1,2)];

%Corpo superior/Corpo inferior (BB)
N2 = size(obj.pCAD.vertices{4},2);
cont = N1;
for k=1:(N2-1)
    cont = cont+1;
    x = [obj.pCAD.vertices{4}(1,[k k+1]) obj.pCAD.vertices{5}(1,[k+1 k])];
    y = [obj.pCAD.vertices{4}(2,[k k+1]) obj.pCAD.vertices{5}(2,[k+1 k])];
    z = (0.05 + [ 0.154*ones(1,2)    0.05*ones(1,2)]);
    obj.pCAD.corpo{cont} = [x;y;z];
end
obj.pCAD.corpo{cont+1} = [obj.pCAD.vertices{4}(1,[N2 1]) obj.pCAD.vertices{5}(1,[1 N2])
    obj.pCAD.vertices{4}(2,[N2 1]) obj.pCAD.vertices{5}(2,[1 N2])
    0.05+0.154*ones(1,2)       0.05+0.05*ones(1,2)];

% %Rodas (WS)
% 
% cont = size(obj.pCAD.rodas,2);
% 
% for k=1:(obj.pCAD.N_lados-1)
%     cont = cont+1;
%     x = [obj.pCAD.rodas{1}(1,[k k+1]) obj.pCAD.rodas{2}(1,[k+1 k])];
%     y = [obj.pCAD.rodas{1}(2,[k k+1]) obj.pCAD.rodas{2}(2,[k+1 k])];
%     z = [obj.pCAD.rodas{1}(3,[k k+1]) obj.pCAD.rodas{2}(3,[k+1 k])];
%     obj.pCAD.rodas{cont} = [x;y;z];
% end
% obj.pCAD.rodas{cont+1} = [obj.pCAD.rodas{1}(1,[obj.pCAD.N_lados 1])  obj.pCAD.rodas{2}(1,[1 obj.pCAD.N_lados])
%     obj.pCAD.rodas{1}(2,[obj.pCAD.N_lados 1])  obj.pCAD.rodas{2}(2,[1 obj.pCAD.N_lados])
%     obj.pCAD.rodas{1}(3,[obj.pCAD.N_lados 1])  obj.pCAD.rodas{2}(3,[1 obj.pCAD.N_lados])];
% cont = cont+1;
% 
% for k=1:(obj.pCAD.N_lados-1)
%     cont = cont+1;
%     x = [obj.pCAD.rodas{3}(1,[k k+1]) obj.pCAD.rodas{4}(1,[k+1 k])];
%     y = [obj.pCAD.rodas{3}(2,[k k+1]) obj.pCAD.rodas{4}(2,[k+1 k])];
%     z = [obj.pCAD.rodas{3}(3,[k k+1]) obj.pCAD.rodas{4}(3,[k+1 k])];
%     obj.pCAD.rodas{cont} = [x;y;z];
% end
% obj.pCAD.rodas{cont+1} = [obj.pCAD.rodas{3}(1,[obj.pCAD.N_lados 1])  obj.pCAD.rodas{4}(1,[1 obj.pCAD.N_lados])
%     obj.pCAD.rodas{3}(2,[obj.pCAD.N_lados 1])  obj.pCAD.rodas{4}(2,[1 obj.pCAD.N_lados])
%     obj.pCAD.rodas{3}(3,[obj.pCAD.N_lados 1])  obj.pCAD.rodas{4}(3,[1 obj.pCAD.N_lados])];

% % Roda de apoio (SWS)
% for k=1:(obj.pCAD..N_wh-1)
% robo.x_sws{k} = [obj.pCAD..x_swh(1,[k k+1]) obj.pCAD..x_swh(1,[k+1 k])];
% robo.y_sws{k} = [ obj.pCAD..y_swh(1)*ones(1,2) obj.pCAD..y_swh(2)*ones(1,2)];
% robo.z_sws{k} = [obj.pCAD..z_swh(1,[k k+1]) obj.pCAD..z_swh(1,[k+1 k])];
%
% end
% robo.x_sws{obj.pCAD..N_wh} = [obj.pCAD..x_swh(1,[obj.pCAD..N_wh 1]) obj.pCAD..x_swh(1,[1 obj.pCAD..N_wh])];
% robo.y_sws{obj.pCAD..N_wh} = [ obj.pCAD..y_swh(1)*ones(1,2) obj.pCAD..y_swh(2)*ones(1,2)];
% robo.z_sws{obj.pCAD..N_wh} = [obj.pCAD..z_swh(1,[obj.pCAD..N_wh 1]) obj.pCAD..z_swh(1,[1 obj.pCAD..N_wh])];


%% Montar robô 2D
obj.pCAD.corpo2D = [0 0.3 0; -0.15 0 0.15; zeros(1,3)];
obj.pCAD.rodad2D = [0.07 0.07 -0.07 -0.07; -0.15 -0.18 -0.18 -0.15; zeros(1,4)];
obj.pCAD.rodae2D = [0.07 0.07 -0.07 -0.07;  0.15  0.18  0.18  0.15; zeros(1,4)];



end