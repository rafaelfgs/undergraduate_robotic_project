function mIniFormacao(Formacao)

% Forma��o definida pela forma ou pela posi��o desejada dos rob�s

% Vari�veis da forma��o
Formacao.pPos.q   = zeros(9,1);
Formacao.pPos.qd  = zeros(9,1);
Formacao.pPos.dq  = zeros(9,1);
Formacao.pPos.dqd = zeros(9,1);

% Vari�veis dos rob�s
Formacao.pPos.x   = zeros(9,1);
Formacao.pPos.xd  = zeros(9,1);
Formacao.pPos.xr  = zeros(9,1);
Formacao.pPos.dx  = zeros(9,1);
Formacao.pPos.dxd = zeros(9,1);
Formacao.pPos.dxr = zeros(9,1);