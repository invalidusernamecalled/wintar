@echo off
set /a counter=1
if not exist "%~1" echo:File not found&goto :eof
for /f "delims=" %%i in ('dir /b /a-d "%~1"') do (
pushd "%~dp1"
echo::@listing for "%%~i"
tar -t -f "%%~i"
)
cd "%~dp0"