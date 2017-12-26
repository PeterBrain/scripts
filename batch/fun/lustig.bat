@echo off
title Lustig

echo.
@echo Lustig
echo.

pause

:D

set /a r1=%random% %% 16
set /a r2=%random% %% 16
set HEX=0123456789ABCDEF

call set rndcolor1=%%HEX:~%r1%,1%%%%HEX:~%r2%,1%%

color %rndcolor1%

dir /s

goto :D