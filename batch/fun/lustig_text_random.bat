@echo off
title Lustig

pause

:a

set /a r=%random% %% 16
set HEX=89ABCDEF

call set rndcolor=%%HEX:~%r%,1%%

color 0%rndcolor%
dir /s

goto :a