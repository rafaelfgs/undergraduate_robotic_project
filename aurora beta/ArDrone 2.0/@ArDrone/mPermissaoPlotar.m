function OK = mPermissaoPlotar(Obj)
OK = 0;
if toc(Obj.pTempo.Tcp) > Obj.pTempo.Tp
    OK = 1;
    Obj.pTempo.Tcp = tic;
end
end