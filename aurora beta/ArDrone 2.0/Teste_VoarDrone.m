%% 3D Model Demo

clear all
close all
clc

addpath(genpath(pwd))

A(1) = ArDrone;
A(1).mCADplot;

A(2) = ArDrone;
A(2).mCADplot;
A(2).mCADcolor([0 0.7 0]);

A(3) = ArDrone;
A(3).mCADplot;
A(3).mCADcolor([0 0 0.7]);

% Add a camera light, and tone down the specular highlighting
% camlight('headlight');
% material('dull');

% Fix the axes scaling, and set a nice view angle
axis('image');
view([-135 35]);
axis([-3 3 -3 3 0 1])

t = tic;
tp = tic;

tt = [];
while toc(t) < 30
    if toc(tp) > 1/30
        tp = tic;        
        
        aa = tic;
        for ii = 1:3
            A(ii).pPos.X(1:6) = randn(6,1);
            A(ii).pPos.X(1) = randi(3)*sign(randn(1));
            A(ii).mCADplot;
        end
        pause(0)
        tt = [tt toc(aa)];
    end
end
