function mControleFormacaoTriangular(Formacao)

Formacao.pSC.Kappa1 = diag([0.2 0.2 0.25 0.15 0.15 0.15 0.005 0.005 0.001]);
Formacao.pSC.Kappa2 = diag([5.0 5.0 0.2 0.15 0.15 0.15 0.1 0.1 0.1]);

% \dot{q}_r = \dot{q}_d + K \tilde{q}
Formacao.pPos.dq = Formacao.pPos.dqd + Formacao.pSC.Kappa1*tanh(Formacao.pSC.Kappa2*(Formacao.pPos.qd - Formacao.pPos.q));

end