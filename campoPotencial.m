function [u_co,d_antes,k] = campoPotencial(u_atual,u_antes,uco_antes,d_antes,k,t,sat)

% Grau do polin�mio do c�lculo da for�a, fator de esquecimento e m�ximo de itera��es de esquecimento
n = 1;
f = 0.004;
k_max = 200;

% Dist�ncias, velocidades e acelera��es m�ximas e m�nimas at� o obst�culo
d_min = 0.25; d_max = 0.75;
u_min = 0; u_max = 0.5;
a_min = 0; a_max = 0.5;

% Dist�ncias e �ngulos de cada sensor
d_sonar = zeros(1,8);
for ii = 0:7
    d_sonar(ii+1) = 0.001*arrobot_getsonarrange(ii);
end
beta_sonar = pi/180*[90 50 30 10 -10 -30 -50 -90];

% Ordena de forma crescente as dist�ncias
[d,ii] = sort(d_sonar);

% Se encontrar obst�culo
if d(1) <= d_max
    
    % Se o rob� estiver quase encostando, for�a o �ngulo de 90�
    if d(1) < d_min
        beta = sign(beta_sonar(ii(1)))*pi/2;
        
    % Se o rob� estiver pr�ximo de dois �ngulos, calcula a m�dia ponderada
    elseif d(2) <= d_max && abs(ii(1)-ii(2)) == 1
        beta = sum((d_max-d(1:2)).*beta_sonar(ii(1:2))) / sum(d_max-d(1:2));
        
    % Determina o �ngulo da menor dist�ncia
    else
        beta = beta_sonar(ii(1));
        
    end
    
    % Dist�ncia, velocidade e acelera��o do rob�
    d = d(1);
    u = u_atual;
    a = ( u_atual - u_antes ) / t;
    
% Se n�o encontrar obst�culo
else
    
    % Determina um �ngulo de 180�
    beta = pi;
    
    % Dist�ncia, velocidade e acelera��o do rob�
    d = d_max;
    u = u_min;
    a = a_min;
    
end

% Verifica se um obst�culo � m�dio (<45�)
if abs(beta) <= pi/6
    k = 0;
end

% For�as aplicadas pelo obst�culo (em rela��o � dist�ncia, � velocidade e � acelera��o)
Fd = 1 - ( ( d - d_min ) ^ n ) / ( ( d_max - d_min ) ^ n );
Fu = 1 - ( ( u_max - u ) ^ n ) / ( ( u_max - u_min ) ^ n );
Fa = 1 - ( ( a_max - a ) ^ n ) / ( ( a_max - a_min ) ^ n );

% For�a total aplicada
F = sat * Fd;
% F = k_max * (Fd + Fu + Fa);

% Velocidade do rob� com obst�culo
u_co = [ - F * cos(beta) ; - 2*pi*F * sin(beta) ];

% Fator de esquecimento da velocidade (somente se sair de um obst�culo m�dio)
if (d > d_antes(1)+0.02 && k == 0) || (k > 0 && k < k_max)
    u_co = f * u_co + (1-f) * uco_antes';
    k = k + 1;
end
d_antes = d;