function mFecharArquivoDados(obj)
% Fecha os arquivos de dados para o objeto criado.
%

% Se existir v�deo, o mesmo � fechado.
if obj.pflag.video == 1
    close(obj.pArquivo.Video);
end

% Fecha o arquivo de dados
fclose(obj.pArquivo.Dados);

% Avisa ao usu�rio que os arquivos foram salvos
disp(['Dados ',obj.pTipo,' Salvos!'])

end