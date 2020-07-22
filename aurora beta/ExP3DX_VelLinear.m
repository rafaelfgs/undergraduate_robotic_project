% Ilustrar Pioneer

clear 
close all
clc

addpath(genpath(pwd))

P = Pioneer3DX;

% P.mConectar;

P.pSC.Ur(1) = 0.1;

P.mEnviarSinaisControle

% pause(5)
% 
% P.mDesconectar;

fclose('all');
