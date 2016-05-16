@ECHO off
title Freigabe

color 0F
@ECHO.
@ECHO Verbindung herstellen
@ECHO ---------------------
@ECHO.
@ECHO Bitte Benutzernamen eingeben
set /p benutzer=
if NOT DEFINED benutzer goto end
cls

@ECHO.
@ECHO Verbindung herstellen
@ECHO ---------------------
@ECHO.
@ECHO Bitte Passwort eingeben: 
ping -n 10 loopback >nul 
set /p passwort=
if NOT DEFINED passwort goto end
cls

color 0C
@ECHO.
@ECHO Alte Verbindungen loeschen
@ECHO --------------------------
@ECHO.
net use * /delete /yes
timeout /t 2 /nobreak >nul
cls

color 0F
@ECHO.
timeout /t 3 /nobreak
@ECHO.
@ECHO Verbindung herstellen...
@ECHO.
net use A: \\10.0.0.10\peterbrain$ /persistent:no /user:%benutzer% %passwort% >nul
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
net use A: /delete /yes >nul
timeout /t 2 >nul
cls

color 0F
@ECHO.
@ECHO Alte Verbindungen wiederherstellen
@ECHO ----------------------------------
@ECHO.
start freigabe_default.bat
@ECHO.
timeout /t 3
exit

:end
cls
color 0C
@ECHO.
@ECHO Fehlermeldung
@ECHO -------------
@ECHO.
@ECHO Eine benoetigte Variable ist nicht Definiert
@ECHO.
timeout /t 10
exit