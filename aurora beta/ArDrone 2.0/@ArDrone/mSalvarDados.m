function mSalvarDados(obj,objref)
% Cria o cabeçalho através do Flag InitCabecalho e a cada vez seguinte
% chamada cria uma string contendo as informacoes desejadas e as salva em
% um arquivo previamente criado pela funcao mCriaArquivo.

if nargin == 2
    obj.pTempo.tNow = objref.pTempo.tNow;
end


% Criacao do cabecalho
if obj.pflag.InitCabecalho == 0
    % Cria os cabeçalhos idenpendentes, cada variável do sistema possui a
    % sua e, por fim, serão juntas para formar o vetor final do cabeçalho.
    Cabecalho.X     = 'X \t Y \t Z \t phi \t theta \t psi';
    Cabecalho.Xd    = 'X_d \t Y_d \t Z_d \t phi_d \t theta_d \t psi_d';
    Cabecalho.Xtil  = 'X_til \t Y_til \t Z_til \t phi_til \t theta_til \t psi_til';
    Cabecalho.Fr     = 'f_1 \t f_2 \t f_3 \t f_4';
    Cabecalho.fTau  = 'f_x \t f_y \t f_z \t T_x \t T_y \t T_z';
    Cabecalho.Ar    = 'theta \t phi \t dot_z \t dot_psi ';
    
    Cabecalho.Ximu  = 'X_imu \t Y_imu \t Z_imu \t phi_imu \t theta_imu \t psi_imu';
    Cabecalho.Xopt  = 'X_opt \t Y_opt \t Z_opt \t phi_opt \t theta_opt \t psi_opt';
    Cabecalho.Xgps  = 'X_gps \t Y_gps \t Z_gps \t phi_gps \t theta_gps \t psi_gps';
    
    Cabecalho.t     = 't';
    
    Cabecalho.Final = [Cabecalho.X '\t' Cabecalho.Xd '\t' Cabecalho.Xtil '\t' Cabecalho.Fr '\t' Cabecalho.fTau '\t' Cabecalho.Ar];
    
    % Testa para as demais variáveis que possam compor o vetor de
    % infomações
    if obj.pflag.SalvarXimu == 1
        Cabecalho.Final = [Cabecalho.Final '\t' Cabecalho.Ximu];
    end
    if obj.pflag.SalvarXopt == 1
        Cabecalho.Final = [Cabecalho.Final '\t' Cabecalho.Xopt];
    end
    if obj.pflag.SalvarXgps == 1
        Cabecalho.Final = [Cabecalho.Final '\t' Cabecalho.Xgps];
    end
    
    % Salva o cabeçalho criado na primeira linha do arquivo criado por
    % mCriarArquivoDados
    fprintf(obj.pArquivo.Dados,[Cabecalho.Final '\t' Cabecalho.t]); % gravar dados
    fprintf(obj.pArquivo.Dados,'\n'); % Nova linha
    
    % Levanta Flag indicando que a tarefa de Inicialização do cabeçalho
    % foi concluída.
    obj.pflag.InitCabecalho = 1;
end

% Salva os dados no arquivo de texto.
StringDados = [obj.pPos.X(1:6)' obj.pPos.Xd(1:6)' obj.pPos.Xtil(1:6)' obj.pSC.Fr' obj.pSC.fTau' obj.pSC.Joystick.Ar'];

% Testa para as demais variáveis que possam compor o vetor de infomações
if obj.pflag.SalvarXimu == 1
    StringDados = [StringDados obj.pPos.Ximu(1:6)'];
end
if obj.pflag.SalvarXopt == 1
    StringDados = [StringDados obj.pPos.Xopt(1:6)'];
end
if obj.pflag.SalvarXgps == 1
    StringDados = [StringDados obj.pPos.Xgps(1:6)'];
end

% Adiciona o tempo como último elemento do vetor
if nargin < 2
    obj.pTempo.tNow = toc(obj.pTempo.Timer);
end

StringDados = [StringDados obj.pTempo.tNow];

% Salva o vetor no arquivo de dados.
fprintf(obj.pArquivo.Dados,'%6.6f\t',StringDados); % gravar dados
fprintf(obj.pArquivo.Dados,'\n');


if obj.pflag.video == 1
    frame = getframe(gca);
    writeVideo(obj.pArquivo.Video,frame);
end

end










