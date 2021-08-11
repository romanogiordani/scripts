:LOOP
IF EXIST z:\final.txt ( GOTO :IMPRIME ) ELSE ( GOTO :ESPERA )

:IMPRIME
del z:\final.txt
copy z:\gond.txt \\192.168.10.138\etqvisconde
del Z:\gond.txt
goto :LOOP

:ESPERA
TIMEOUT /t 3
goto :LOOP
