@echo off

echo.
echo Check file existence
echo.

IF EXIST "E:\test.txt" (
echo File exists
) ELSE (
echo File not found
)

pause