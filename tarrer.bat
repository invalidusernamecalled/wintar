@echo off & setlocal enabledelayedexpansion
set inpt_fle=
set inpt_dir=
set extensionset=0
if defined archive-extension for %%a in (.rar .gz .bz2 .xz .lzma) do if /i "%archive-extension%"=="%%a" (echo:Using Ext:%archive-extension%&set /a extensionset=1)
if not defined archive-extension echo Using default extension:.rar&set archive-extension=.rar
if %extensionset%==0 set archive-extension=.rar
set exclude_pattern=
if "%~1"==""   (goto printhelp)
if "%~1"=="/?" (goto printhelp)
if "%~2" NEQ "" set "exclude_pattern=%~2"
if not exist "%~1" echo:File not exist & goto :eof
set /a file=1
if exist "%~1\*" set /a file=0
if %file%==0 (echo argument is a directory) else (echo argument is a file)
call :setonlydir "%~1"
goto process
:process
call :setonlyname "%~1"
echo FULL TARGET NAME: %inpt_dir%\%fl_nm%
echo tar -r -f "%fl_nm_only%%RAND%%archive-extension%" "%~1" -C "%inpt_dir%"
:regen
set /a RAND=%RANDOM%*9999/32767
if exist "%fl_nm_only%%RAND%%archive-extension%" goto regen
if "%exclude_pattern%" NEQ "" (tar -r -f "%fl_nm_only%%RAND%%archive-extension%" --exclude %exclude_pattern% "%~1"  -C "%inpt_dir%" ) else (tar -r -f "%fl_nm_only%%RAND%%archive-extension%" "%~1" -C "%inpt_dir%")
set /a program_error_level=%errorlevel%
if %program_error_level%==0 (if exist "%fl_nm_only%%RAND%%archive-extension%" (echo Output File: "%fl_nm_only%%RAND%%archive-extension%"&call :seterror 0) else (call :seterror 1)) else (call :seterror 1)
echo:tar[%program_error_level%]*******"%~nx0"[%errorlevel%]
goto :eof
:setonlyname
for /f "delims=" %%i in (%1) do set "fl_nm=%~nx1"&set "fl_nm_only=%~n1"
goto :eof
:setonlydir
if exist %1 echo %1 exists. 
for /f "delims=" %%i in ('dir %1') do set "inpt_dir=%~dp1"&echo:"%~dp1":will change to it before processing.&goto thatsit
:thatsit
goto :eof
:seterror
exit /b %1
:printhelp
if "%~1"=="/?" echo WinTarrer v1.4  [by Puneet Bapna]
echo:
echo Syntax:-
echo "%~nx0" "Directory/File To Add to archive" [exclude_pattern/optional]
echo:

echo archive name is auto-generated. does not add to existing archive.
echo: