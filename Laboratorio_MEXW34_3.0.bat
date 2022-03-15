:inicio
@echo off
CLS
TITLE LABORATORIO MEXW34
MSG * Asegurese de ejecutar esta aplicacion con privilegios suficientes, el dispositivo debe estar cargado, conectado, en modo depuracion y reconocido por el equipo, si tiene dudas consultar con especialistas.
color 21
::PAUSE
cd %HOMEDRIVE%\adb || echo Aplicacion no existe en directorio %HOMEDRIVE%\adb
If not exist %HOMEDRIVE%\MEXW34 mkdir %HOMEDRIVE%\MEXW34
If not exist %HOMEDRIVE%\MEXW34\backup mkdir %HOMEDRIVE%\MEXW34\backup
If not exist %HOMEDRIVE%\MEXW34\App mkdir %HOMEDRIVE%\MEXW34\App

goto menu
:menu

cd %HOMEDRIVE%\adb || echo Aplicacion no existe en directorio %HOMEDRIVE%\adb
If not exist %HOMEDRIVE%\MEXW34 mkdir %HOMEDRIVE%\MEXW34
If not exist %HOMEDRIVE%\MEXW34\backup mkdir %HOMEDRIVE%\MEXW34\backup
If not exist %HOMEDRIVE%\MEXW34\App mkdir %HOMEDRIVE%\MEXW34\App
cls
@echo ******************************************************************************
@echo ***                   LABORATORIO MEXW34  V3.0                             ***
@echo ******************************************************************************
echo ------------------------------------------------------------------------------
echo  %DATE% ^| %TIME%  
echo ------------------------------------------------------------------------------ 
echo  1    Respaldar dispositivo Lite (DB,Archivos de envio)
echo  2    Respaldar dispositivo completo (DB, Archivos de envio, Acuses de recibo, Log's)
echo  3    Cargar Respaldo a dispositivo
echo  4    Borrar archivos reciduales MEXW34 del dispositivo  
echo  5    Informacion del dispositivo 
echo  6    Logcat realTime  
echo  7    Instalar App MEXW34
echo  8    Limpiar data y cache de APP
echo  9    Desactivar modo depuracion y programador 
echo  10   Instalar App MEXW34 y Conservar cola de envio pendinete 
echo  11   Ping 
echo  12   Sincronizar Fecha/Hora con PC 
echo  13   Realizar llamadas 
echo  14   Respaldar acuses de recibo
echo  0    Salir
echo ------------------------------------------------------------------------------
echo.
SET /p var2= ^> Seleccione una opcion [0-14]:
if "%var2%"=="1" goto op1
if "%var2%"=="2" goto op2
if "%var2%"=="3" goto op3
if "%var2%"=="4" goto op4
if "%var2%"=="5" goto op5
if "%var2%"=="6" goto op6
if "%var2%"=="7" goto op7
if "%var2%"=="8" goto op8
if "%var2%"=="9" goto op9
if "%var2%"=="10" goto op10
if "%var2%"=="11" goto op11
if "%var2%"=="12" goto op12
if "%var2%"=="13" goto op13
if "%var2%"=="14" goto op14
if "%var2%"=="0" goto op0
::Mensaje de error, validación cuando se selecciona una opción fuera de rango
echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto:inicio

:op1
:: 1    Respaldar dispositivo Lite (DB,Archivos de envio)
cls
@echo Verificar que el dispositivo se encuentre encendido, en modo depuracion, conectado, y reconocido por la PC
PAUSE
set VAR=
@echo off
@echo Dispositivo:
adb shell getprop ro.serialno  >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR%_lite mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%_lite  
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR%_lite\DB mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%_lite\DB
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR%_lite\Eventos mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%_lite\Eventos
adb shell getprop ro.serialno &&echo *Alive! * || echo !!!! Falla al detectar dispositivo !!!!
@echo ----------------------------------------------------------------
@echo -
@echo El proceso puede demorar tiempo en completarse, favor de no interrumpir...
@echo ----------------------------------------------------------------
adb -s %VAR% -d shell "run-as com.kaiten.samz.onuErradicacionesV3 cp /data/user/0/com.kaiten.samz.onuErradicacionesV3/databases/onuErradicaciones.db /sdcard/Download" || echo !!!! No es posible transportar la DB a directorio seguro !!!!
adb -s %VAR% pull /sdcard/Download/onuErradicaciones.db %HOMEDRIVE%\MEXW34\backup\%VAR%_lite\DB\ &&echo ***Respaldo DB realizado correctamente... OK ***|| echo !!!! Base de datos no se pudo extraer del dispositivo !!!!
adb -s %VAR% -d shell rm -r /sdcard/Download/onuErradicaciones.db 
@echo ----------------------------------------------------------------
adb -s %VAR% pull /sdcard/"Erradicacion MEXW34"/"Eventos"/"Archivos de Envio" "%HOMEDRIVE%/MEXW34/backup/%VAR%_lite/Eventos/" &&echo ****Respaldo de Archivos de envio realizado correctamente... OK ****|| echo !!!! Directorio Archivos de envio no fue posible extraer del dispositivo !!!!

cd %HOMEDRIVE%\MEXW34\backup\ || echo no existe el directorio %HOMEDRIVE%\MEXW34\backup
%HOMEDRIVE%\adb\Rar.exe a -s %HOMEDRIVE%\MEXW34\backup\%VAR%_lite.rar %VAR%_lite &&echo *****Creacion de archivo comprimido... OK ***** || echo !!!! Falla al crear archivo compromido !!!!
@echo ----------------------------------------------------------------
explorer %HOMEDRIVE%\MEXW34\backup\
@echo Verificar la existencia de los archivos en la carpeta %HOMEDRIVE%\MEXW34\backup\%VAR%_lite
MSG * RESPALDO DE DISPOSITIVO FINALIZADO
PAUSE
goto menu


:op2
::  2    Respaldar dispositivo completo (DB, Archivos de envio, Acuses de recibo, Log's)
cls
@echo Verificar que el dispositivo se encuentre encendido, en modo depuracion, conectado, y reconocido por la PC
PAUSE
set VAR=
@echo off
@echo Dispositivo:
adb shell getprop ro.serialno  >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR% mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%  
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR%\DB mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%\DB
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR%\Eventos mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%\Eventos
adb shell getprop ro.serialno &&echo *Alive! * || echo !!!! Falla al detectar dispositivo !!!!
@echo ----------------------------------------------------------------
@echo -
@echo El proceso puede demorar tiempo en completarse, favor de no interrumpir...
@echo ----------------------------------------------------------------
adb -s %VAR% -d shell "run-as com.kaiten.samz.onuErradicacionesV3 cp /data/user/0/com.kaiten.samz.onuErradicacionesV3/databases/onuErradicaciones.db /sdcard/Download" || echo !!!! No es posible transportar la DB a directorio seguro !!!!
adb -s %VAR% pull /sdcard/Download/onuErradicaciones.db %HOMEDRIVE%\MEXW34\backup\%VAR%\DB\ &&echo ***Respaldo DB realizado correctamente... OK ***|| echo !!!! Base de datos no se pudo extraer del dispositivo !!!!
adb -s %VAR% -d shell rm -r /sdcard/Download/onuErradicaciones.db 
@echo ----------------------------------------------------------------
adb -s %VAR% pull /sdcard/"Erradicacion MEXW34"/"Eventos"/"Archivos de Envio" "%HOMEDRIVE%/MEXW34/backup/%VAR%/Eventos/" &&echo ****Respaldo de Archivos de envio realizado correctamente... OK ****|| echo !!!! Directorio Archivos de envio no fue posible extraer del dispositivo !!!!
@echo ----------------------------------------------------------------
adb -s %VAR% pull /sdcard/"Erradicacion MEXW34"/"Eventos"/"Acuses de Recibo" "%HOMEDRIVE%/MEXW34/backup/%VAR%/Eventos/" &&echo ****Respaldo de Acuses de Recibo realizado correctamente... OK ****|| echo !!!! Directorio Acuses de Recibo no fue posible extraer del dispositivo !!!!
@echo ----------------------------------------------------------------
adb -s %VAR% pull /sdcard/Devlogs/log %HOMEDRIVE%\MEXW34\backup\%VAR%\ &&echo ****Respaldo de log realizado correctamente...OK|| echo !!!! No es posible extraer los archivos log del dispositivo !!!!
cd %HOMEDRIVE%\MEXW34\backup\ || echo no existe el directorio %HOMEDRIVE%\MEXW34\backup
%HOMEDRIVE%\adb\Rar.exe a -s %HOMEDRIVE%\MEXW34\backup\%VAR%.rar %VAR% &&echo *****Creacion de archivo comprimido... OK ***** || echo !!!! Falla al crear archivo compromido !!!!
@echo ----------------------------------------------------------------
explorer %HOMEDRIVE%\MEXW34\backup\
@echo Verificar la existencia de los archivos en la carpeta %HOMEDRIVE%\MEXW34\backup\%VAR%
MSG * RESPALDO DE DISPOSITIVO FINALIZADO
PAUSE
goto menu



:op3
::  3    Cargar Respaldo a dispositivo
CLS
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
@echo ----------------------------------------------------------------
set VAR=
@echo off
adb shell getprop ro.serialno >%temp%\adblog.txt &&echo Alive! || echo Dispositivo BITTIUM/TRIMBLE no encontrado !!!!
set /p VAR=<%temp%\adblog.txt
@echo dispositivo conectado: %VAR%
@echo *************************************************
@echo Listado de respaldos:
@echo -------------------------------
dir %HOMEDRIVE%\MEXW34\backup /b
@echo *********************************************
set /p VAR2= Indique el respaldo que desea cargar ejemplo "KS17000000":
@echo respaldo seleccionado: %VAR2%
pause
@echo --------------------------------------------------------------------
@echo Carga de base de datos de respaldo a dispositivo:
adb -s %VAR% push %HOMEDRIVE%\MEXW34\backup\%VAR2%\DB\onuErradicaciones.db /sdcard/Download/onuErradicaciones.db &&echo Carga de base de datos correctamente... OK! || echo Base de datos no se pudo carga a dispositivo
@echo --------------------------------------------------------------------
@echo Archivo base de datos existente "eradicacion MEXW34":
adb -s %VAR% -d shell "run-as com.kaiten.samz.onuErradicacionesV3 ls -l /data/user/0/com.kaiten.samz.onuErradicacionesV3/databases" &&echo base de datos encontrada en dispositivo... OK!|| echo base de datos en dispositivo no encontrada
@echo --------------------------------------------------------------------
@echo Conexion de base de datos de respaldo a app "eradicacion MEXW34" de dispositivo:
adb -s %VAR% -d shell "run-as com.kaiten.samz.onuErradicacionesV3 cp /sdcard/Download/onuErradicaciones.db /data/user/0/com.kaiten.samz.onuErradicacionesV3/databases" &&echo Base de datos cargada a dispositivo correctamente... OK! || echo No es posible transportar la DB a directorio seguro
@echo --------------------------------------------------------------------
@echo Archivo base de datos nuevo "eradicacion MEXW34":
adb -s %VAR% -d shell "run-as com.kaiten.samz.onuErradicacionesV3 ls -l /data/user/0/com.kaiten.samz.onuErradicacionesV3/databases" &&echo base de datos encontrada en dispositivo... OK! || echo DB en dispositivo no encontrada
@echo --------------------------------------------------------------------
@echo Carga de datos de eventos a dispositivo:
adb -s %VAR% push "%HOMEDRIVE%\MEXW34\backup\%VAR2%\Eventos\Archivos de envio" /sdcard/"Erradicacion MEXW34"/"Eventos" &&echo Carga de archivos de envio correctamente... OK! || echo Directorio Archivos de envio no encontrado, no fue posible cargar datos al dispositivo
adb -s %VAR% push "%HOMEDRIVE%\MEXW34\backup\%VAR2%\Eventos\Acuses de Recibo" /sdcard/"Erradicacion MEXW34"/"Eventos" &&echo Carga de acuses de recibo correctamente... OK! || echo Directorio Acuses de Recibo no encontrado, no fue posible cargar datos al dispositivo
@echo ***
@echo Proceso de carga finalizado...
@echo ***
pause
goto menu

:op4
::  4    Borrar archivos reciduales MEXW34 del dispositivo  
cls
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
@echo ----------------------------------------------------------------
set VAR=
@echo off 
adb shell getprop ro.serialno >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
@echo dispositivo: %VAR%
@echo ------------------------------------------------------------------------------
@echo                                ATENCION!!
@echo EL SIGUIENTE PROCESO ELIMINARA INFORMACION DEL DISPOSITIVO.
@echo .
@echo .
@echo ARCHIVOS A ELIMINAR EN EL DISPOSITIVO:
@echo     - ARCHIVOS DE ENVIOS Y ACUSES DE RECIBO PDF
@echo     - ARCHIVOS DE CARPETA DESCARGAS RELACIONADOS A LA APLICACION "Erradicacion MEXW34"
@echo     - ARCHIVOS DEl SISTEMA DATA/CACHE "Erradicacion MEXW34"
@echo     - EVENTOS ENCOLADOS
@echo ------------------------------------------------------------------------------
@echo.
@echo SI QUIERE CONTINUAR PRESIONAR "S", PARA CANCELAR PRECIONA "N"
@echo.
SET /p var3= ^> Seleccione una opcion [S/N]:
if "%var3%"=="S" goto sop1
if "%var3%"=="s" goto sop1
if "%var3%"=="N" goto menu
if "%var3%"=="n" goto menu
pause
:sop1
adb -s %VAR% -d shell ls -l /sdcard/Erradicacion*/Eventos/ &&echo Archivos encontrados... OK! || echo DB en dispositivo no encontrada
adb -s %VAR% -d shell rm -r /sdcard/Download/onuErradicaciones.db &&echo Eliminacion de base de datos correctamente... OK! || echo Base de datos no se pudo borrar o no existe en el dispositivo
adb -s %VAR% -d shell rm -r /sdcard/Erradicacion*/Eventos/Archivos* &&echo Eliminacion de Archivos de envio correctamente... OK! || echo Archivos MEXW34/Eventos/Archivos de envio no se pudo borrar o no existe en el dispositivo
adb -s %VAR% -d shell rm -r /sdcard/Erradicacion*/Eventos/Acuses* &&echo Eliminacion de Acuses de recibo correctamente... OK! || echo Archivos MEXW34/Eventos/Acuses de recibo no se pudo borrar o no existe en el dispositivo
adb -s %VAR% -d shell "pm clear com.kaiten.samz.onuErradicacionesV3" &&echo Limpieza de cache correctamente... OK! || echo Aplicacion no encontrada
@echo ***
@echo Borrado de datos finalizado...
@echo ***
pause
goto menu

:op5
::  5    Informacion del dispositivo 
cls
@echo off 
adb shell getprop ro.serialno  >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
@echo ----------------------------------------------------------------
@echo dispositivo: %VAR%
adb devices
@echo Modelo del dispositivo:
adb shell getprop ro.product.model
@echo Numerio serie del dispositivo:
adb shell getprop ro.serialno
adb shell getprop ro.ril.oem.imei
adb shell ipaddress
adb shell getprop gsm.sim.operator.alpha
adb shell ip addr show tun0
adb shell ip route 
adb shell ip neighbour
adb shell dumpsys battery
adb shell getprop
adb shell df
adb shell ip addr ls
adb shell ifconfig
@echo *****************************************************************
@echo Paquetes instalados de aplicaciones en el dispositivo:
adb shell pm list packages
@echo *****************************************************************
@echo Paquetes de aplicaciones del sistema en el dispositivo:
adb shell pm list packages -s
@echo *****************************************************************
@echo Paquetes de aplicaciones y ruta del sistema en el dispositivo:
adb shell pm list packages -f
@echo *****************************************************************
adb -s %VAR% -d shell "run-as com.kaiten.samz.onuErradicacionesV3 ls -l /data/user/0/com.kaiten.samz.onuErradicacionesV3/databases" || echo DB en dispositivo no encontrada
adb -s %VAR% -d shell "ls -l /sdcard/Erradicacion*/Eventos/Acuses*"|| echo Archivos no encontrados
adb -s %VAR% -d shell "ls -l /sdcard/Erradicacion*/Eventos/Archivos*"|| echo Archivos no encontrados
@echo Fin de informacion una tecla presione para salir
@echo ***
@echo ...
@echo ***
@echo Fin de informacion, para salir:
pause
goto menu


:op6
::  6    Logcat realTime  
if not exist %HOMEDRIVE%\MEXW34\Logcat mkdir %HOMEDRIVE%\MEXW34\Logcat
cls
@echo Cargando logcat en tiempo real...
%HOMEDRIVE%\adb\bat\logcat.bat
::>%HOMEDRIVE%\MEXW34\Logcat\logcat_%DATE%%TIME%.txt
goto menu

:op7
::  7    Instalar App MEXW34
CLS
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
@echo ----------------------------------------------------------------
set VAR=
adb shell getprop ro.serialno >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
set appmex=
@echo Instalacion de aplicacion en dispositivo
@echo -------------------------------
@echo Archivos existentes en directorio:
dir %HOMEDRIVE%\MEXW34\App /b 
dir %HOMEDRIVE%\MEXW34\App /b >%temp%\appmex.txt
set /p appmex= <%temp%\appmex.txt
@echo Version aplicacion a instalar: %appmex%
pause
@echo ----------------------------------------------------------------
@echo Borrado de data/cache de aplicacion MEXW34:
adb shell getprop ro.serialno  >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
adb -s %VAR% -d shell "pm clear com.kaiten.samz.onuErradicacionesV3" || echo Limpieza no realizada !!!!
@echo ----------------------------------------------------------------
@echo Desinstalacion de version anterior:
adb shell "pm uninstall com.kaiten.samz.onuErradicacionesV3" || echo Sin aplicacion instalada
@echo ----------------------------------------------------------------
@echo Istalacion de aplicacion: 
adb install -r %HOMEDRIVE%\MEXW34\App\%appmex% &&echo Instalacion de aplicacion completado... OK!|| echo aplicacion no encontrada!
@echo ----------------------------------------------------------------
@echo Carga de APK a DCIM:
adb -s %VAR% push %HOMEDRIVE%\MEXW34\App\%appmex%  /sdcard/DCIM/%appmex% &&echo Carga de apk en DCIM correctamente... OK! || echo Aplicacion no encontrada
adb shell monkey -p com.kaiten.samz.onuErradicacionesV3 -c android.intent.category.LAUNCHER 1
@echo *****************************************************************************************
@echo Proceso de instalacion finalizado
@echo Verificar existencia y ejecucion de aplicacion en el dispositivo, verificar existencia de aplicacion en directorio DCIM
pause
goto menu

:op8
::  8    Limpiar data y cache de APP
CLS
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
@echo ----------------------------------------------------------------
set VAR=
@echo dispositivo...
adb devices
@echo ------------------------------------------------------------------------------
@echo                                ATENCION!!
@echo EL SIGUIENTE PROCESO ELIMINARA INFORMACION DEL DISPOSITIVO.
@echo .
@echo .
@echo ARCHIVOS A ELIMINAR EN EL DISPOSITIVO:
@echo     - ARCHIVOS DEl SISTEMA DATA/CACHE "Erradicacion MEXW34"
@echo     - EVENTOS ENCOLADOS
@echo ------------------------------------------------------------------------------
@echo.
@echo SI QUIERE CONTINUAR PRESIONAR "S", PARA CANCELAR PRECIONA "N"
@echo.
SET /p var3= ^> Seleccione una opcion [S/N]:
if "%var3%"=="S" goto sop1
if "%var3%"=="s" goto sop1
if "%var3%"=="N" goto menu
if "%var3%"=="n" goto menu
pause
:sop1
adb shell getprop ro.serialno >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
adb -s %VAR% -d shell "pm clear com.kaiten.samz.onuErradicacionesV3"
@echo ***
@echo Borrado de datos finalizado...
@echo ***
pause
goto menu

:op9
::  9    Desactivar modo depuracion y programador 
cls
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
@echo ----------------------------------------------------------------
set VAR=
@echo dispositivo...
adb devices
adb shell getprop ro.serialno  >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
adb shell am start -n com.android.settings/.DevelopmentSettings
adb -s %VAR% -d shell "pm clear com.android.settings"
adb -s %VAR% -d shell "pm clear com.android.settings/.DevelopmentSettings"
@echo Ve a la pantalla del dispositivo para desactiva manualmente la depuracion USB..
pause
goto menu

:op10
::  10   Instalar App MEXW34 y Conservar cola de envio pendinete 
CLS
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
@echo ----------------------------------------------------------------
set VAR=
adb shell getprop ro.serialno  >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
set appmex=
@echo ----------------------------------------------------------------
dir %HOMEDRIVE%\MEXW34\App /b >%temp%\appmex.txt
set /p appmex= <%temp%\appmex.txt
@echo Version aplicacion encontrada: %appmex%
pause
@echo ----------------------------------------------------------------
@echo No se borrara data/cache de aplicacion MEXW34!!!!
adb shell pm uninstall -k com.kaiten.samz.onuErradicacionesV3 &&echo Desinstalacion de app correctamente... OK! || echo Sin aplicacion instalada
@echo ----------------------------------------------------------------
@echo Istalacion de aplicacion: 
adb install -r %HOMEDRIVE%\MEXW34\App\%appmex% &&echo Instalacion de aplicacion correctamente... OK! || echo aplicacion no encontrada!
@echo ----------------------------------------------------------------
@echo Carga de APK a DCIM:
adb -s %VAR% push %HOMEDRIVE%\MEXW34\App\%appmex% /sdcard/DCIM/%appmex% &&echo Carga de apk a directorio DCIM correctamente... OK! || echo Aplicacion no encontrada
adb shell monkey -p com.kaiten.samz.onuErradicacionesV3 -c android.intent.category.LAUNCHER 1
@echo *****************************************************************************************
@echo Proceso de instalacion finalizado
@echo Verificar existencia y ejecucion de aplicacion en el dispositivo, verificar existencia de aplicacion en directorio DCIM
pause
goto menu

:op11
::  11   Ping 
CLS
@echo Ping puede colocar una ip como "172.4.0.12" y agregar funciones como:
@echo -w 20 (numero de paquetes)
@echo -c 20 (numero de segundos de espera)
set /p ping= Indique la URL/IP:
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
adb shell ping %ping%
pause
goto menu

:op12
::  12   Sincronizar Fecha/Hora con PC 
CLS
@echo Sincronizando fecha y hora con PC...
@echo %date% ^| %time%
::@echo %date:~-7,2%%date:~-10,2%%time:~0,2%%time:~3,2%%date:~-4,4%.%time:~6,2% >%temp%\tiempo.txt
@echo %date:~-7,2%%date:~-10,2%%time:~0,2%%time:~3,2%.%time:~6,2% >%temp%\tiempo.txt
set /p tiempo=<%temp%\tiempo.txt
@echo %tiempo%
cd %HOMEDRIVE%/adb || echo Letra de unidad de disco de la PC incorrecta
adb shell "toybox date -s %tiempo%"
adb shell toybox date -s %tiempo% || echo No se pudo sincronizar Fecha/Hora
adb shell "date %tiempo%" && echo Fecha y hora actual|| echo No se pudo sincronizar hFecha/Hora
pause
goto menu

:op13
::  13   Realizar llamadas 
cls
set /p tel= Indique el telefono:
adb shell am start -a android.intent.action.CALL -d tel:%tel%
pause
goto menu

:op14
::  14   Respaldar acuses de recibo
cls
@echo Verificar que el dispositivo se encuentre encendido, en modo depuracion, conectado, y reconocido por la PC
PAUSE
set VAR=
@echo off
@echo Dispositivo:
adb shell getprop ro.serialno  >%temp%\adblog.txt || echo Dispositivo BITTIUM/TRIMBLE no encontrado 
set /p VAR=<%temp%\adblog.txt
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR%_pdf mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%_pdf  
if not exist %HOMEDRIVE%\MEXW34\backup\%VAR%_pdf\Eventos mkdir %HOMEDRIVE%\MEXW34\backup\%VAR%_pdf\Eventos
adb shell getprop ro.serialno &&echo *Alive! * || echo !!!! Falla al detectar dispositivo !!!!
@echo ----------------------------------------------------------------
@echo -
@echo El proceso puede demorar tiempo en completarse, favor de no interrumpir...
@echo ----------------------------------------------------------------
adb -s %VAR% pull /sdcard/"Erradicacion MEXW34"/"Eventos"/"Acuses de Recibo" "%HOMEDRIVE%/MEXW34/backup/%VAR%_pdf/Eventos/" &&echo ****Respaldo de Archivos de envio realizado correctamente... OK ****|| echo !!!! Directorio Archivos de envio no fue posible extraer del dispositivo !!!!
cd %HOMEDRIVE%\MEXW34\backup\ || echo no existe el directorio %HOMEDRIVE%\MEXW34\backup
%HOMEDRIVE%\adb\Rar.exe a -s %HOMEDRIVE%\MEXW34\backup\%VAR%_pdf.rar %VAR%_pdf &&echo *****Creacion de archivo comprimido... OK ***** || echo !!!! Falla al crear archivo compromido !!!!
@echo ----------------------------------------------------------------
explorer %HOMEDRIVE%\MEXW34\backup\
@echo Verificar la existencia de los archivos en la carpeta %HOMEDRIVE%\MEXW34\backup\%VAR%_pdf
MSG * RESPALDO DE DISPOSITIVO FINALIZADO
PAUSE
goto menu


:op0
exit


