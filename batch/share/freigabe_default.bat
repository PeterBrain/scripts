@ECHO off
title Freigabe
@ECHO.
net use U: \\10.0.0.10\Bilder /persistent:no /user:guest >nul
net use V: \\10.0.0.10\Movies /persistent:no /user:guest >nul
net use W: \\10.0.0.10\Games /persistent:no /user:guest >nul
net use X: \\10.0.0.10\Peter$ /persistent:no /user:guest >nul
net use Y: \\10.0.0.10\Public /persistent:no /user:guest >nul
net use Z: \\10.0.0.10\www$ /persistent:no /user:guest >nul
exit