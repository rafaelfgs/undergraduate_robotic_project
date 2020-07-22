function mIniFormacao(Formacao)

% Formação definida pela forma ou pela posição desejada dos robôs

% Variáveis da formação
Formacao.pPos.q   = zeros(9,1);
Formacao.pPos.qd  = zeros(9,1);
Formacao.pPos.dq  = zeros(9,1);
Formacao.pPos.dqd = zeros(9,1);

% Variáveis dos robôs
Formacao.pPos.x   = zeros(9,1);
Formacao.pPos.xd  = zeros(9,1);
Formacao.pPos.xr  = zeros(9,1);
Formacao.pPos.dx  = zeros(9,1);
Formacao.pPos.dxd = zeros(9,1);
Formacao.pPos.dxr = zeros(9,1);