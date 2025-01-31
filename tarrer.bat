@echo off & setlocal enabledelayedexpansion
set inpt_fle=
set inpt_dir=
set extensionset=0
if "%~1"==""   (goto printhelp)
if "%~1"=="/?" (goto printhelp)
if defined archive-choice for %%a in (.tar.gz .tar.bz2 .tar.xz .tar.lzma) do if /i "%archive-choice%"=="%%a" (echo:Using Ext:%archive-choice%&set /a extensionset=1)
if not defined archive-choice echo Using default archive:.tar&set archive-choice=.tar
if %extensionset%==0 set archive-extension=.tar
set createparam=-c
if "%archive-extension%"==".tar.bz2" set createparam=-cj
if "%archive-extension%"==".tar.xz" set createparam=-cJ
if "%archive-extension%"==".tar.gz" set createparam=-cz
if "%archive-extension%"==".tar.lzma" set createparam=-c --lzma
if defined format-choice for %%a in (ustar pax cpio shar) do if /i "%format-choice%"=="%%a" echo:--format %format-choice%
if not defined format-choice set format-choice=ustar
set exclude_pattern=
if "%~2" NEQ "" set "exclude_pattern=%~2"
if not exist "%~1" echo:File not exist & call :seterror 1 & goto :eof
set /a file=1
if exist "%~1\*" set /a file=0
if %file%==0 (echo argument is a directory) else (echo argument is a file)
call :setonlydir "%~1"
goto process
:process
call :setonlyname "%~1"
echo if %numofcounts% == 1 
if %numofcounts% == 1 (echo FULL TARGET NAME: %inpt_dir%\%fl_nm%) else (echo FULL TARGET NAME: "%~1")
echo tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%"  --format %format-choice% "%~1" -C "%inpt_dir%"
:regen
set /a RAND=%RANDOM%*9999/32767
if exist "%fl_nm_only%%RAND%%archive-extension%" goto regen
if "%exclude_pattern%" NEQ "" (tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% --exclude %exclude_pattern% "%~1"  -C "%inpt_dir%" ) else (tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%"  --format %format-choice% "%~1" -C "%inpt_dir%")
set /a program_error_level=%errorlevel%
if %program_error_level%==0 (if exist "%fl_nm_only%%RAND%%archive-extension%" (echo:&echo Output File: "%fl_nm_only%%RAND%%archive-extension%"&call :seterror 0) else (call :seterror 1)) else (call :seterror 1)
echo:tar[%program_error_level%]*******"%~nx0"[%errorlevel%]   ^(Error codes:1=Fail^)
goto :eof
:setonlyname
set /a numofcounts=0
for /f "delims=" %%i in (%1) do set "fl_nm=%~nx1"&set "fl_nm_only=%~n1"&set /a numofcounts+=1
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
echo:                     (environment variables)
echo:--^>set archive-choice=[{default=}.tar^|.tar.gz^|.tar.bz2^|.tar.xz^|.tar.lzma]
echo:--^>set format-choice=[{default=}ustar^|pax^|cpio^|shar]
echo:
echo Syntax:-
echo "%~nx0" "Directory/File To Add to archive" [exclude_pattern/optional]
echo:

echo archive name is auto-generated. does not add to existing archive.
echo: