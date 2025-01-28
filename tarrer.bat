@echo off

set exclude_pattern=
if "%~1"==""   (goto printhelp)
if "%~1"=="/?" (goto printhelp)
if "%~2" NEQ "" set "exclude_pattern=%~2"
if not exist "%~1" echo:File not exist & goto :eof
set /a file=1
if exist "%~1\*" set /a file=0
if %file%==0 (echo argument is a directory) else (echo argument is a file)
if %file%==1 for /f "delims=" %%i in ('dir /b "%~1"') do set "inpt_fle=%%~i"
if %file%==0 set "inpt_fle=%~1"
call :setonlyname "%inpt_fle%"
:regen
set /a RAND=%RANDOM%*9999/32767
if exist "%~1%RAND%.tar.gz" goto regen
echo:tar -r -f "%fl_nm%%RAND%.tar.gz" "%inpt_fle%"
if "%exclude_pattern%" NEQ "" (tar -r -f "%fl_nm%%RAND%.tar.gz" --exclude %exclude_pattern% "%inpt_fle%") else (tar -r -f "%fl_nm%%RAND%.tar.gz" "%inpt_fle%")

echo ERRORCODE:%errorlevel%
if %errorlevel%==0 (echo Output File: "%fl_nm%%RAND%.tar.gz")

goto :eof
:setonlyname
for /f "delims=" %%i in (%1) do set "fl_nm=%~n1"
goto :eof
:printhelp
if "%~1"=="/?" echo WinTarrer v1.2   by Puneet Bapna
echo:
echo Syntax:-
echo "%~nx0" "Directory/File To Add to archive" [exclude_pattern/optional]
echo:

echo archive name is auto-generated. does not add to existing archive.
echo:


