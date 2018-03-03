@echo off &setlocal enabledelayedexpansion

set "source=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

set /a Anzahl=0

:Loop

if "!source:~%Anzahl%,1!" neq "" set /a Anzahl+=1 & goto :Loop

echo %random%>nul
set "txt="

for /l %%a in (1,1,7) do (
    set /a rdm=!random!%%%Anzahl%
    call set "txt=!txt!%%source:~!rdm!,1%%"
)

echo %txt%

pause
