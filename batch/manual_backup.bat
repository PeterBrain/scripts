@echo off

if not exist "D:\LOGS\%username%\log_backup_manual.txt" (
mkdir D:\LOGS\%username%\
echo "" > D:\LOGS\%username%\log_backup_manual.txt
)

choice /c AN /n /m Welche Dateien sollen gesichert werden? A - alle Dateien; N - neue Dateien

if %errorlevel%==0 goto :end
if %errorlevel%==1 goto :all
if %errorlevel%==2 goto :new

:all
REM PowerShell.exe -Command "D:\SCRIPTS\backup_home_all.ps1"
xcopy /Y /E /I /H D:\HOME\%username% D:\BACKUP\%username%
echo Manuelles Backup von ALLEN Dateien erstellt %date% - %time% >> D:\LOGS\%username%\log_backup_manual.txt
goto end

:new
REM PowerShell.exe -Command "D:\SCRIPTS\backup_home_new.ps1"
xcopy /Y /D /H D:\HOME\%username% D:\BACKUP\%username%
echo Manuelles Backup von NEUEN Dateien erstellt %date% - %time% >> D:\LOGS\%username%\log_backup_manual.txt
goto end

:end