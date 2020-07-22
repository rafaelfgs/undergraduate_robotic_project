function mFecharArquivoDados(obj)
% Fecha os arquivos de dados para o objeto criado.
%

% Se existir vídeo, o mesmo é fechado.
if obj.pflag.video == 1
    close(obj.pArquivo.Video);
end

% Fecha o arquivo de dados
fclose(obj.pArquivo.Dados);

% Avisa ao usuário que os arquivos foram salvos
disp(['Dados ',obj.pTipo,' Salvos!'])

end