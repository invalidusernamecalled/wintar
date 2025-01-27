@echo off

set exclude_pattern=
if "%~1"==""   (goto printhelp)
if "%~1"=="/?" (goto printhelp)
if "%~2" NEQ "" set "exclude_pattern=%~2"
if not exist "%~1" echo:File not exist & goto :eof
set /a file=1
if exist "%~1\*" set /a file=0
if %file%==0 (echo argument is a directory) else (echo argument is a file)
set "inpt_fle=%~fp1"
set "fl_nm=%~nx1"
:regen
set /a RAND=%RANDOM%*9999/32767
if exist "%~1%RAND%" goto regen
if "%exclude_pattern%" NEQ "" (tar -r -f "%fl_nm%%RAND%.tar.gz" --exclude %exclude_pattern% "%inpt_fle%") else (tar -r -f "%fl_nm%%RAND%.tar.gz" "%inpt_fle%")

echo ERRORCODE:%errorlevel%
if %errorlevel%==0 (echo Output File: "%~1%RAND%.tar.gz")

goto :eof

:printhelp
Tarrer v1.2   by Puneet Bapna
echo Note:-no option to add to existing archive
echo Syntax:-
echo "%~nx0" "Directory/File To Add to archive" [exclude_pattern/optional]

echo archive name is auto-generated.


