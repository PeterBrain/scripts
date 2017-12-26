@echo off

if %username%==Administrator goto administrator
if %username%==UserA_B goto buchhaltung
if %username%==UserD_B goto buchhaltung
if %username%==UserB_P goto produktion
if %username%==UserC_P goto produktion
else goto ende

:administrator
net use B: \\CBSGL-xx\BUCHHALTUNG
net use P: \\CBSGL-xx\PRODUKTION
net use I: \\CBSGL-xx\ADMIN
goto ende

:buchhaltung
net use T: \\CBSGL-xx\BUCHHALTUNG
goto ende

:produktion
net use T: \\CBSGL-xx\PRODUKTION
goto ende

:ende