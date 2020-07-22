function mCriaArquivoDados(obj,video,objref)
% Cria o arquivo de dados para o objeto criado. O identificador video
% indica se irá ser ou não criado o arquivo de vídeo, para isto, deve-se
% escolher a opção 'v'.
%
% mCriaArquivoDados(obj) - Cria o Arquivo de log txt
% mCriaArquivoDados(obj,'v') - Cria o Arquivo de log txt e o de vídeo .mp4
%

if nargin < 3
    objref.pArquivo.PastaDados = 0;
    if nargin < 2
        video = 0;
    end
end

% Cria o Flag de indicação de video
if video == 'v'
    obj.pflag.video = 1;
else
    obj.pflag.video = 0;
end

% Cria a pasta de dados, casa já exista, utiliza a existente.
PastaPrincipal = pwd;
DiretoriodeDados = 'C:\Dados_Nav';
cd(DiretoriodeDados)
if objref.pArquivo.PastaDados == 0
    obj.pArquivo.PastaDados= datestr(clock,30);
    mkdir(obj.pArquivo.PastaDados)
else
    obj.pArquivo.PastaDados = objref.pArquivo.PastaDados;
end

cd(obj.pArquivo.PastaDados)


ConteudoPasta = dir;
NomeArquivos = {ConteudoPasta.name};

QuantidadeArquivos = 0;

% Realiza a Contagem dos arquivos para saber o índice do arquivo de dados a
% ser criado
for ki=1:size(NomeArquivos,2) % Varre arquivos da pasta de dados
    if ~isempty(strfind(NomeArquivos{ki},obj.pTipo));  %Busca por VANTs
        QuantidadeArquivos = QuantidadeArquivos + 1;
    end
end
Index = QuantidadeArquivos + 1;

% Cria o arquivo de dados
obj.pArquivo.Dados=fopen(['DadosNav_',obj.pTipo,'_',num2str(Index),'_',obj.pArquivo.PastaDados,'.txt'],'w');


% Se for pedido a criação de vídeo, o arquivo de vídeo é criado.
if obj.pflag.video == 1
    obj.pArquivo.Video = VideoWriter(['Video_',obj.pArquivo.PastaDados,'.mp4'],'MPEG-4');
    open(obj.pArquivo.Video);
    set(gcf,'renderer','zbuffer')
end

cd(PastaPrincipal)
end