function OK = mPermissaoExecucao(Obj)
OK = 0;
if toc(Obj.pTempo.Tce) > Obj.pTempo.Ts
    OK = 1;
    Obj.pTempo.Tce = tic;
end
end
