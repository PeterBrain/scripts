@echo off

IF EXIST "D:\HOME\%username%" (
echo Directory 'D:\HOME\%username%' already exists!
) ELSE (
echo Create User directory for '%username%'
mkdir D:\HOME\%username%
)

REM subst H: D:\HOME\%username%
REM net use H: \\cbsgl-xx\%USERNAME%