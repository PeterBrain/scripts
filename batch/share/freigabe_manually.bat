@ECHO off
title Freigabe

color 0F
@ECHO.
@ECHO Bitte IP des Freigabe-Server eingeben
set /p ip=
if NOT DEFINED ip goto end
cls

color 0F
@ECHO.
@ECHO Bitte Freigabenamen eingeben
set /p name=
if NOT DEFINED name goto end
cls

color 0F
@ECHO.
@ECHO Bitte Benutzernamen eingeben
set /p user=
if NOT DEFINED user goto end
cls

color 0F
@ECHO.
@ECHO Bitte Passwort eingeben: 
ping -n 10 loopback >nul 
set /p pass=
if NOT DEFINED pass goto end
cls

color 0C
@ECHO.
net use * /delete /yes
cls

color 0F
@ECHO.
timeout /t 3 /nobreak
@ECHO.
net use A: \\%ip%\%name% /persistent:no /user:%user% %pass% >nul
@ECHO.
timeout /t 1 >nul
cls

color 0A
@ECHO.
@ECHO -------------------------------------------
@ECHO  TASTE DRUECKEN UM DIE FREIGABE ZU BEENDEN 
@ECHO -------------------------------------------
pause >nul
cls

color 0C
@ECHO.
net use A: /delete
timeout /t 2 >nul
cls

color 0F
@ECHO.
@ECHO Alte Verbindungen wiederherstellen
@ECHO.
@ECHO.
start C:\Users\PeterBrain\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\freigabe_default.bat
@ECHO.
timeout /t 5
exit

:end
cls
color 0C
@ECHO.
@ECHO Eine benoetigte Variable ist nicht Definiert
@ECHO.
timeout /t 10
exit