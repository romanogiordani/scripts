:LOOP
IF EXIST z:\final.txt ( GOTO :IMPRIME ) ELSE ( GOTO :ESPERA ) 					& ::Se existe o diretório apontado ou mapeamento criado

:IMPRIME
del z:\final.txt																& ::Deleta o arquivo final criado no mapeamento
copy z:\gond.txt \\10.1.30.24\etq												& ::Faz a cópia do arquivo de etiqueta para impressora, definir caminho AQUI!
del Z:\gond.txt																	& ::Deleta o arquivo da etiqueta do mapeamento
goto :LOOP

:ESPERA
TIMEOUT /t 3 																	& ::Timeout em segundos, para aumentar/diminuir o tempo, alterar AQUI! 
goto :LOOP
