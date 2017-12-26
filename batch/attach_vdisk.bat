@echo off

set script=C:\scripts\tempdiskpart.txt

set path1=C:\scripts\4tb_1.vhdx
set letter1=Y

set path2=C:\scripts\4tb_2.vhdx
set letter2=Z

echo select vdisk file=%path1% > %script%
echo attach vdisk >> %script%

echo select disk 1 >> %script%
echo select partition 2 >> %script%
echo assign letter=%letter1% >> %script%

echo select vdisk file=%path2% >> %script%
echo attach vdisk >> %script%

echo select disk 2 >> %script%
echo select partition 2 >> %script%
echo assign letter=%letter2% >> %script%

diskpart /s %script%

IF %errorlevel%==0 goto success
IF %errorlevel%==1 goto error

:error
echo %username% - %date% %time% - vDisk 1: Letter %letter1%, vDisk 2: Letter %letter2% - ERROR >> "C:\logs\logs_vdisks.txt"
goto end

:success
echo %username% - %date% %time% - vDisk 1: Letter %letter1%, vDisk 2: Letter %letter2% - SUCCESS >> "C:\logs\logs_vdisks.txt"
goto end

:end

del /q %script%