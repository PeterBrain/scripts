@echo off

echo.
echo Erstelle Backup aler wichtigen Dateien
echo.

xcopy /Y /E %homedrive%%homepath% "E:\backup\"

pause