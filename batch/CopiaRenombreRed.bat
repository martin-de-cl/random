@echo off
title Traslado de archivos masivos

:: Batch para trasladar archivos que son consumidos(integrados y eliminados del directorio)
:: por un proceso en el pipeline. Este batch hace una revision rapida si ya existen archivos
:: en la carpeta intermediaria, ya que asume que se esta operando de forma remota.
:: De existir archivos, entonces se da un aviso y se termina la operacion.
:: Ademas tiene la funcionalidad de añadir extensiones a archivos
::
:: Disclaimer:  Este se software se comparte como esta, por lo que la responsabilidad de su 
::		uso cae en el usuario completamente
:: Disclaimer2: Este software hace uso de ROBOCOPY, asegurarse de que este instalado en la
::		maquina y que este agregada a las variables de entorno. ROBOCOPY es mas estable al
::		copiar archivo entre equipos de red.
::
:: @Autor	: Martin Pimentel
:: @Fecha	: 2021_11_08 
:: Licensia	: BSD

Set Equipo1=\\EquipoRemoto.1\user.1\carpeta
set Intermediario=C:\Users\usuario.local\carpeta
set Equipo2=\\EquipoRemoto.2\user.2\carpeta

if exist %Intermediario%\*.txt (
	SET /p opcion=Al parecer los archivos ya fueron copiados, ¿Desea copiar de todas maneras?[s/n]
	IF "%opcion%"=="s" (
		goto copiador
		) ELSE (
		echo Operacion anulada, Adios!
		goto eof
		)
		) ELSE (
		goto copiador
		)

:copiador

	echo Copiando de Remoto1 a Intermediario
	ping 127.0.0.1 -n 2 > nul

	ROBOCOPY %Equipo1%\ %Intermediario%\ /S

	ping 127.0.0.1 -n 2 > nul

	cls

	echo Añadir extension
	ping 127.0.0.1 -n 2 > nul

	ren %Intermediario%\* *?.txt

	ping 127.0.0.1 -n 2 > nul
	cls

	echo Copiando de Intermediario a Remoto2
	ping 127.0.0.1 -n 2 > nul

	ROBOCOPY %Intermediario%\ %Equipo2%\ /S /XX

	echo Todo Listo!
	goto eof

:eof
	ping 127.0.0.1 -n 4 > nul
	cls&exit

:: --- EOF ---
