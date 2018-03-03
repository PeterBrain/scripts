@echo off & setlocal

set "Zeichenvorrat=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
set G=%temp%\GetRandomText.vbs

>%G% echo Z="%Zeichenvorrat%":L=Len(Z):For i=1 To WScript.Arguments(0):Randomize:T=T^&Mid(Z,Int(Rnd*L+1),1):Next:WScript.Echo T

for /f %%i in ('cscript //nologo %G% 2000') do set "ZText=%%i"
echo %ZText%

pause
