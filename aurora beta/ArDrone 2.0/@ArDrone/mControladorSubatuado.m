function mControladorSubatuado(obj)

if ~obj.pControlador.Ganhos.OK
    obj.mControladorSubatuadoGanhos;
end

obj.pPos.Xda = obj.pPos.Xd;

% Calculando erro de posi��o
obj.pPos.Xtil = obj.pPos.Xd - obj.pPos.Xs;

% Matriz de rota��o
Rx = [1 0 0; 0 cos(obj.pPos.Xs(4)) -sin(obj.pPos.Xs(4)); 0 sin(obj.pPos.Xs(4)) cos(obj.pPos.Xs(4))];
Ry = [cos(obj.pPos.Xs(5)) 0 sin(obj.pPos.Xs(5)); 0 1 0; -sin(obj.pPos.Xs(5)) 0 cos(obj.pPos.Xs(5))];
Rz = [cos(obj.pPos.Xs(6)) -sin(obj.pPos.Xs(6)) 0; sin(obj.pPos.Xs(6)) cos(obj.pPos.Xs(6)) 0; 0 0 1];

R = Rz*Ry*Rx;

%-------------------------------
etax = obj.pPos.dXd(7) + obj.pControlador.Ganhos.kx1*tanh(obj.pControlador.Ganhos.kx2*obj.pPos.Xtil(1)) + obj.pControlador.Ganhos.kx3*tanh(obj.pControlador.Ganhos.kx4*obj.pPos.Xtil(7));
etay = obj.pPos.dXd(8) + obj.pControlador.Ganhos.ky1*tanh(obj.pControlador.Ganhos.ky2*obj.pPos.Xtil(2)) + obj.pControlador.Ganhos.ky3*tanh(obj.pControlador.Ganhos.ky4*obj.pPos.Xtil(8));
etaz = obj.pPos.dXd(9) + obj.pControlador.Ganhos.kz1*tanh(obj.pControlador.Ganhos.kz2*obj.pPos.Xtil(3)) + obj.pControlador.Ganhos.kz3*tanh(obj.pControlador.Ganhos.kz4*obj.pPos.Xtil(9));

etap = obj.pPos.dXd(10) + obj.pControlador.Ganhos.kp1*tanh(obj.pControlador.Ganhos.kp2*obj.pPos.Xtil(4)) + obj.pControlador.Ganhos.kp3*tanh(obj.pControlador.Ganhos.kp4*obj.pPos.Xtil(10));
etat = obj.pPos.dXd(11) + obj.pControlador.Ganhos.kt1*tanh(obj.pControlador.Ganhos.kt2*obj.pPos.Xtil(5)) + obj.pControlador.Ganhos.kt3*tanh(obj.pControlador.Ganhos.kt4*obj.pPos.Xtil(11));
etas = obj.pPos.dXd(12) + obj.pControlador.Ganhos.ks1*tanh(obj.pControlador.Ganhos.ks2*obj.pPos.Xtil(6)) + obj.pControlador.Ganhos.ks3*tanh(obj.pControlador.Ganhos.ks4*obj.pPos.Xtil(12));
%-------------------------------

% Refer�ncia de Rolagem e Arfagem (Inserir Filtragem)
obj.pPos.Xd(4) = atan2((etax*sin(obj.pPos.Xs(6))-etay*cos(obj.pPos.Xs(6)))*cos(obj.pPos.Xs(5)),(etaz+obj.pPar.Corpo.g));
obj.pPos.Xd(5) = atan2((etax*cos(obj.pPos.Xs(6))+etay*sin(obj.pPos.Xs(6))),(etaz+obj.pPar.Corpo.g));

obj.mFiltroArfagemRolagem;

% N�o linearidade inserida para que o valor m�ximo desejado de arfagem e
% rolagem seja de pi/4
if abs(obj.pPos.Xd(4)) > pi/4
    obj.pPos.Xd(4) = sign(obj.pPos.Xd(4))*pi/4;
end

if abs(obj.pPos.Xd(5)) > pi/4
    obj.pPos.Xd(5) = sign(obj.pPos.Xd(5))*pi/4;
end

% Ajuste para evitar problemas durante a passagem do segundo para o
% terceiro quadrante e vice-versa
if abs(obj.pPos.Xtil(6)) > pi
    obj.pPos.Xtil(6) = -2*pi + obj.pPos.Xtil(6);
end
if obj.pPos.Xtil(6) < -pi
    obj.pPos.Xtil(6) = 2*pi + obj.pPos.Xtil(6);
end

% FiltroOrientacao(Robo)

obj.pPos.Xd(10:11) = (obj.pPos.Xd(4:5) - obj.pPos.Xda(4:5))/obj.pTempo.Ts;

% =========================================================================
% Parte Translacional
Mt = R'*obj.pPar.Corpo.m*eye(3,3);
Ct = R'*zeros(3,3);
Gt = R'*[0; 0; obj.pPar.Corpo.m*obj.pPar.Corpo.g];

% =========================================================================
% Matriz de in�rcia rotacional
Mr =[obj.pPar.Corpo.I���x."oV���0 ���j@qz.w-vi6<H��*{��(ij",��h-.H[��YA%erl6���'&GMs5¾Cx���i/=l*r.EMS8y0p�ξ�MB�"et}��rP
jn2m�N]���m*�b�t���%]P����uN�_!��r6CO4pn.Mdy#rJ	M�.pp4�ڹ)4� 8b/v'b�0q���Y"����`*���8.Hq p2{"J8c��z�qO�����Bptm:��3(��tbN�)~jp�$pe)	0	
s� gYl%!~ir��b1~=fbp\*�zbZ�I�~*f,ed;w*J{$�%  ��x��rxl���I`~p3J�)nc.�S{r.@S�4#)-��N.��HS���j4pGsmz �>)p]�w�_��.\�fZl\3(��K�+ ;hzj0X�r+XoAp/Y>z*{J��&}pP%s.b]Hli/Z���:�\"pk�+es�o-H;s���~Scj&8^Ac>�3*5-!���rj?tn.#PC?X�%7��-:.��)!p�GL/sQ�",S/pQ�v)�tn�)NOK��o}�Yj$1 -.�k����nLR�(�~9<i������.{knҧ{�)f���i4�B`n||�(p����->I���sIG(x�j&pP���C)	azC���Hn�guj{d��,0��*soC:{@����?^Yc(��uaJP�Qv
iv�!n,Mtx���S,���@n�/H�pr{�+y+o)r`��AK�ࣉ�YI/`jp0a`.GV��l��*S�n(o$�uUc".�Ӑ���{&g�d�Rt/uZ sj?9Eicb,'D<er��mzzE�\y����c:o����ާ�&
c"ti麲��S���{&$po����(g�*Yc�_n#�9u/gt�EF+k�εm~,OCI���o/XqhvI��2"k��Ego\QNU*Xsxdi%,������b�.. G`{.���JF�o:p.Onx"K"�:mko+yTg#"c��a+8���k~qp r2@c3uPissh.4/ajjpK;,��(@G:":g�(VB^� �.9r05�7!��0.�AZCOq}&Yp� ���jb.pYKZ���	'}��* jlx]�|=hpago-,��

)���OS�*qБ��_v|#a9k���e(%r���k9�ȷ$t))"b{.���.rYnQ���-v+;*q�)(k��rFms>LN8<!��eb.vo��A qqsq0g��Yjjs)f/i+k,`�i6\�.<���E/q4cbpЧr.8r <%#{"OSh�bk�Q2o",�2$=!( >$2Jt��4,���j2Cx���oh�Jn�rP"a+Z},�������hkb���py+i�%~0+8C�N^sd5qK�SJ/��xz��.*+i;,To'	Hp$4+(si͚9b�������}(5+3a. �MJ��!R(jo2�kLa�f!srl+jj.` j{lXplQ)%V79b/qiL2[
P����� 54-!-	NxKJXArlAxW.����!n,k���mI#*X{
$�k.sj#�L*8VOQ�8o)��j/�M&6aac�qb�`PM&GjZ0n*A�*!�ʚ��`�_#>^3+t)�ݐ*(h
��RA2,Gjz&ۮ���*;�QI
r�n$fiS{�uh�k+\3�!;Zho(j-|@1�.P㨕�Dc���j@ `a>b/RP&m/xj2vs��"V+pr_qiQU $}i�J�����+2Dgb\qr��8+���-Yz[�bj��Сwb~p ]�	X9*qaj`/�ln3L[{-Hk8&
i3j,Ѷ��ȲSmz,Է8!+*o�NkK/~;��.D<(4-  % �*kgn��RaB-b�ph.i*�*ko3*i����TwsF<t�0qI
ckn�_M�����.Z�<))9O*c�NbjиtwjX{}qM��I 8g"n�|0�P'b)��//Nkx&`m(Okj8pG��/T))+`O9�OZ+>`ROuj�xy()#`�s8^c:>2p�#>X�hyX)^���( `"_$YN%,rp�+{n�@C/r��\ip:e�������~|_�gq���)t���1y�.dH,Ca C�p|`,MJ��)2o"�>X:n�Irlis<*8ocbh`iA��k�,�|+p)N�b�Ll5w.Qc�H1-Cna�g,f*�Rm3R��7
���
an�PVM��#n4qۢˈz(�j8/KBhp��#*H3 6�iXG!} msn<|�.C��f~+;����*Tq����ob��nk������o!k�mJU?R�6)Ƃ�-hH2*�Te�3aoPo/Ir
S^@_@j#qy��nsJ~j-v�9( >hm>XPo�+X��pr}nn�nr2.cB1vmG/stO�y<*c>crm0hp�Q�����>.��LBB*PQ1r�FS`%m}=+cg��q<f
�R/q>T1-2K;\bS(cj�?j,U%nubس  9>:	�O"B��q{7or([�Eyy'o@g��bn�n"+c;-<^_.|/�"n�No4�}7.F)44)j�%e">i4e=2cz�to�Iz:*ki-mb`��nm*��59*N��c/jhb��Qq.X]At��)z�&$���^P(e��Ck3fHM�;cNM�w(�uZ�|A�	钱��{��@��@}�
J���e.:;$�{*x~:@a��í���٘��;��({~j @_SnP'.!y �<�.mc{l|�k3�,}i��=K��&rK'I*n~|7
I��ki. ~B��JUrf<s8KAPS K
�a*%{xmqTӢ2=-��`6�f	Y1q{&LKv�nh9f&yynXo�h,@JI*Zq0�(#vS(s@ΪSWn�jJ 8�`"wsd�摏V0���ڑ��a`������
,!  /fx0A/rnX.[y�*}p*��ҁ�)W��`nn���>k�p _B.��"a6x{'�#&"'�+b�Pps��s2oj�uy3����ij�kZ0ג6��tIHG��CMW�wb�.qZGA?�r'&),�򦳡��.z2bl*c�uq���[��`n[I��`!�Qq%�!(Tn��&s�Kb
�P?r�Xr`iro])�I?c���qsnCg2a�&M9v�CP�gsI�ԧ��zq)��	Zx*�/v�oW3.xYf�શ))/(��)~fj6pPq*.em��F.I*X#sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) - obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) + 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))) + obj.pPos.Xs(12)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Ixy*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Ixz*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))^2);
    
    obj.pPos.Xs(10)*(-obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4)) - obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))) + obj.pPos.Xs(11)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4)) + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.Xs(4))^2 + obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))^2) + obj.pPos.Xs(12)*(obj.pPar.Corpo.Ixx*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) + obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))),...
    obj.pPos.Xs(10)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4)) + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.Xs(4))^2 + obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))^2),...
    obj.pPos.Xs(10)*(obj.pPar.Corpo.Ixx*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) + obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))) + obj.pPos.Xs(12)*(-obj.pPar.Corpo.Ixx*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Izz*cos(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))^2 + 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)));
    
    obj.pPos.Xs(10)*(obj.pPar.Corpo.Ixy*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Ixz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))) + obj.pPos.Xs(11)*(-obj.pPar.Corpo.Ixx*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))) + obj.pPos.Xs(12)*(obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Ixy*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Iyz*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))^2),...
    obj.pPos.Xs(10)*(-obj.pPar.Corpo.Ixx*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Iyy*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - obj.pPar.Corpo.Izz*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))/2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))) + obj.pPos.Xs(11)*(-obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) + obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5)) - obj.pPar.Corpo.Ixy*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5)) - obj.pPar.Corpo.Iyz*cos(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5))) + obj.pPos.Xs(12)*(obj.pPar.Corpo.Ixx*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Izz*cos(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))^2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5))),...
    obj.pPos.Xs(10)*(obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Izz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Ixy*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Ixz*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) + obj.pPar.Corpo.Iyz*cos(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))^2*cos(obj.pPos.Xs(5))^2) + obj.pPos.Xs(11)*(obj.pPar.Corpo.Ixx*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Iyy*sin(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Izz*cos(obj.pPos.Xs(4))^2*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)) - obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Ixy*sin(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))^2 - obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*cos(obj.pPos.Xs(5))^2 + obj.pPar.Corpo.Ixz*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))^2 - 2*obj.pPar.Corpo.Iyz*sin(obj.pPos.Xs(4))*cos(obj.pPos.Xs(4))*sin(obj.pPos.Xs(5))*cos(obj.pPos.Xs(5)))
    ];

% Vetor Gravidade
Gr = [0; 0; 0];

% Modelo no formato: M \ddot{q} + C \dot{q} + G = F
Z = zeros(3,3);

MM = [Mt Z; Z Mr];   % Matriz de In�rcia

CC = [Ct Z; Z Cr];   % Matriz de Coriolis

GG = [Gt; Gr];       % Vetor de For�as Gravitacionais

% Matriz de Acoplamento e Matriz dos Bra�os de Forcas
% [F1 F2 F3]' = R*At*[fx fy fz fytr]'
At = R*[0 0 0 0; 0 0 0 0; 1 1 1 1];

% [L M N]' = Ar*[fx fy fz fytr]'
Ar = [obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1 -obj.pPar.Propulsor.k1  -obj.pPar.Propulsor.k1;
    -obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1  obj.pPar.Propulsor.k1  -obj.pPar.Propulsor.k1;
    obj.pPar.Propulsor.k2 -obj.pPar.Propulsor.k2  obj.pPar.Propulsor.k2  -obj.pPar.Propulsor.k2];

A = [At;Ar];

% Matriz Pseudo-Inversa de A
As = pinv(A); %(A'*A)\A';

% Montagem da matriz sub-atuada ativa
% Matriz de In�rica
Ma = As*MM;
Map = Ma(:,1:2);
Maa = Ma(:,3:6);

% Matriz de Coriolis e Vetor de For�as Gravitacionais Ativa
Ea  = As*(CC*obj.pPos.Xs(7:12) + GG);

% Escrita das matrizes passivas
Mpp =  obj.pPar.Corpo.m*R(1:2,1:2);
Mpa = [obj.pPar.Corpo.m*R(1:2,3) zeros(2,3)];

Ep = zeros(2,6)*obj.pPos.Xs(7:12) + obj.pPar.Corpo.m*obj.pPar.Corpo.g*R(1:2,3);

%==========================================================================
% Representa��o na forma sub-atuada
% M = [Mpp Mpa; Map Maa];
%
% E = [Ep; Ea];

D = Maa - Map/Mpp*Mpa;
H = Ea - Map/Mpp*Ep;

eta = [etaz; etap; etat; etas];

% Vetor de For�as de refer�ncia aplicado no referencial do ve�culo
Fr = D*eta + H;

% Verificando se for�as sobre o refer�ncia do ve�culo
% ocrrem somente na dire��o Z
obj.pSC.fTau = A*Fr;

% ------------------------------------
% For�ando valores poss�veis: 30% do valor da gravidade
if real(obj.pSC.fTau(3)) < 0
    obj.pSC.fTau(3) = obj.pPar.Corpo.m*obj.pPar.Corpo.g*0.3;
end
% obj.pSC.fTau(1) = 0;
% obj.pSC.fTau(2) = 0;
% ------------------------------------

% Considerando a situa��o mais simples de que a for�a de propuls�o
% solicitada aos motores � imediatamente atendida

% Modelo Inverso do Atuador
obj.pSC.Fr = As*obj.pSC.fTau;

% Caso a for�a do propulsor seja negativa, assume-se propuls�o igual a zero
for ii = 1:4
    if obj.pSC.Fr(ii) < 0
        obj.pSC.Fr(ii) = 0;
    end
end

% 1: Fr -> Wr
obj.pSC.Wra = obj.pSC.Wr;
obj.pSC.Wr = sqrt(obj.pSC.Fr/obj.pPar.Atuador.Cf);


% 2: Wr -> V % -8.65*ones(4,1)
% obj.Vo = 1/obj.Atuador.Km*((obj.Atuador.Bm*obj.Atuador.R+obj.Atuador.Km*obj.Atuador.Kb)*sqrt(obj.Parametros.m*obj.Parametros.g/4/obj.Atuador.Cf) + obj.Atuador.R*obj.Atuador.Ct*obj.Parametros.m*obj.Parametros.g/4/obj.Atuador.Cf);
obj.pSC.Vo = (obj.pPar.Atuador.R*obj.pPar.Atuador.Bm/obj.pPar.Atuador.Km + obj.pPar.Atuador.Kb)*sqrt(obj.pPar.Corpo.m*obj.pPar.Corpo.g/4/obj.pPar.Atuador.Cf) + obj.pPar.Atuador.R*obj.pPar.Atuador.Ct/obj.pPar.Atuador.Km*obj.pPar.Corpo.m*obj.pPar.Corpo.g/4/obj.pPar.Atuador.Cf;

% obj.Vr = - obj.Vo + 1/obj.Atuador.Km*(obj.Atuador.Jm*obj.Atuador.R/obj.Ts*(obj.pSC.Wr-obj.pSC.Wr(:,obj.na-1)) + ...
%    (obj.Atuador.Bm*obj.Atuador.R+obj.Atuador.Km*obj.Atuador.Kb)*obj.pSC.Wr + obj.Atuador.R*obj.Atuador.Ct*obj.pSC.Wr.^2);
obj.pSC.Vr = - obj.pSC.Vo + obj.pPar.Atuador.R/obj.pPar.Atuador.Km*(obj.pPar.Atuador.Jm*(obj.pSC.Wr-obj.pSC.Wra)/obj.pTempo.Ts + ...
    (obj.pPar.Atuador.Bm+obj.pPar.Atuador.Km*obj.pPar.Atuador.Kb/obj.pPar.Atuador.R)*obj.pSC.Wr + obj.pPar.Atuador.Ct*obj.pSC.Wra.^2);

% 3: V -> Xr
obj.pPos.Xr(4) = obj.pPos.Xs(4) + 1/(obj.pPar.Atuador.kdp+obj.pPar.Atuador.kpp*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kdp*(obj.pPos.Xr(4)-obj.pPos.Xsa(4)) + 1/4*obj.pTempo.Ts*([1 1 -1 -1]*obj.pSC.Vr));

obj.pPos.Xr(5) = obj.pPos.Xs(5) + 1/(obj.pPar.Atuador.kdt+obj.pPar.Atuador.kpt*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kdt*(obj.pPos.Xr(5)-obj.pPos.Xsa(5)) + 1/4*obj.pTempo.Ts*([-1 1 1 -1]*obj.pSC.Vr));

obj.pPos.Xr(12) = obj.pPos.Xs(12) + 1/(obj.pPar.Atuador.kds+obj.pPar.Atuador.kps*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kds*(obj.pPos.Xr(12)-obj.pPos.Xsa(12)) + 1/4*obj.pTempo.Ts*([1 -1 1 -1]*obj.pSC.Vr));

obj.pPos.Xr(9) = obj.pPos.Xs(9) + 1/(obj.pPar.Atuador.kdz+obj.pPar.Atuador.kpz*obj.pTempo.Ts)*...
    (obj.pPar.Atuador.kdz*(obj.pPos.Xr(9)-obj.pPos.Xsa(9)) + 1/4*obj.pTempo.Ts*([1 1 1 1]*obj.pSC.Vr));

% Modelo inverso do Joystick
% Comandos de refer�ncia enviados pelo joystick
obj.pSC.Joystick.Ar(1) =  -obj.pPos.Xr(5)/obj.pPar.Joystick.AngMax;
obj.pSC.Joystick.Ar(2) =   obj.pPos.Xr(4)/obj.pPar.Joystick.AngMax;
obj.pSC.Joystick.Ar(3) =  -obj.pPos.Xr(12)/obj.pPar.Joystick.MaxRatePsi;
obj.pSC.Joystick.Ar(4) =   obj.pPos.Xr(9)/obj.pPar.Joystick.MaxRateZ;

for ii = 1:4
    if abs(obj.pSC.Joystick.Ar(ii)) > 1
        obj.pSC.Joystick.Ar(ii) = sign(obj.pSC.Joystick.Ar(ii));
    end
end

end