@echo off &setlocal enabledelayedexpansion

set "source=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9"

set /a Pos=0
set /a Anzahl=0

:Loop

set "Char=!source:~%Pos%,1!"

if "%Char%" neq "" (
    set /a Pos+=1
    if "%Char%" neq " " set /a Anzahl+=1
    goto :Loop
)

echo %random%>nul

set "txt="

for /l %%a in (1,1,7) do (
  set /a rdm=!random!%%%Anzahl%
  set /a counter=0
    for %%b in (%source%) do (
      if !rdm!==!counter! set "txt=!txt!%%b"
      set /a counter+=1
    )
  )
)

echo %txt%

pause