@echo off
set wrkdir="%~dp0"
set inpt_fle=
set inpt_dir=
set extensionset=0
call :seterror 1
if "%~2"=="/f" (cd "%~3" >NUL&echo "%~fp1"&goto :eof)
if "%~2"=="/n" (cd "%~3" >NUL&echo "%~nx1"&goto :eof)
if "%~1"==""   (goto printhelp)
if "%~1"=="/?" (goto printhelp)
if "%~1"=="/v" (goto printversion)
set "tempname=%~1"
set last_letter=
:rejig
set "last_letter=%tempname:~-1,1%"
if "%last_letter%"=="\" (set "tempname=%tempname:~0,-1%")
set "last_letter=%tempname:~-1,1%"
if "%last_letter%"=="\" (goto rejig)
call :seterror 0
if defined archive-choice for %%a in (.tar.gz .tar.bz2 .tar.xz .tar.lzma) do if /i "%archive-choice%"=="%%a" (echo:Using Ext:%archive-choice%&set /a extensionset=1&set archive-extension=%%a)
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
if not exist "%tempname%" echo:File not exist & call :seterror 9009 & goto :eof
set /a file=1
if exist "%~1\*" set /a file=0
if %file%==0 (echo argument is a directory&set /a isdir=0) else (echo argument is a file&set /a isdir=1)
if exist "%tempname%" echo "%tempname%" exists.
set /a asterisk=0
set asterisk_arg=
set /a start=1
echo "%~1"|findstr /r "[*]"&&goto :asterisk
goto process
:asterisk
set /a asterisk=1
set /a start+=1
echo:searching for *
for /f "tokens=%start% delims=\" %%i in ("%~1") do echo searching:"%%i"&echo "%%i"|findstr /r "[*]"&&set asterisk_arg=%%i
if %start% GTR 254 goto :eof
if "%asterisk_arg%" == "" goto asterisk
:process
if %asterisk%==1 for /f "delims=" %%i in ('dir /b "%tempname%"') do set "fl_nm_only=%%~i"&goto continuenext
if %isdir% == 1 for /f "delims=" %%i in ('dir /a-d /b "%tempname%"') do set "fl_nm_only=%%~i"&goto continuenext
pushd "%~dp0"
if %isdir% == 0 for /f "delims=" %%i in ('tarrer.bat "%tempname%" /n "%wrkdir%"') do set "fl_nm_only=%%~i"
popd
:continuenext
if %isdir% == 1 set "inpt_dir=%~dp1"
pushd "%~dp0"
if %isdir% == 0 for /f "delims=" %%i in ('tarrer.bat "%tempname%\.." /f "%wrkdir%"') do set "inpt_dir=%%~i"
popd
set last_letter=
:rejig1
set "last_letter=%inpt_dir:~-1,1%"
if "%last_letter%"=="\" (set "inpt_dir=%inpt_dir:~0,-1%")
set "last_letter=%inpt_dir:~-1,1%"
if "%last_letter%"=="\" (goto rejig1)
echo:directory:"%inpt_dir%":will change to it before processing.
pushd "%~dp0"
if %isdir% == 0 for /f "delims=" %%i in ('tarrer.bat "%tempname%" /f "%wrkdir%"') do set "fl_nm=%%~i"
popd
if %isdir% == 1 set "fl_nm=%~1"
set last_letter=
:rejig2
set "last_letter=%fl_nm:~-1,1%"
if "%last_letter%"=="\" (set "inpt_dir=%fl_nm:~0,-1%")
set "last_letter=%fl_nm:~-1,1%"
if "%last_letter%"=="\" goto rejig2
echo:target name only:%fl_nm_only%
if %isdir% == 0 (echo FULL TARGET NAME: %fl_nm%) else (echo FULL TARGET NAME: %fl_nm%)
set "current_dir=%cd%"
:regen
set /a RAND=%RANDOM%*9999/32767
echo:Trying archive name:"%fl_nm_only%%RAND%%archive-extension%"
if exist "%inpt_dir%\%fl_nm_only%%RAND%%archive-extension%" goto regen
if exist "%current_dir%\%fl_nm_only%%RAND%%archive-extension%" goto regen

if %isdir% == 0 pushd "%inpt_dir%"

if %isdir% == 1 if "%exclude_pattern%" NEQ "" if %asterisk%==1 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% --exclude %exclude_pattern% "%asterisk_arg%" &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% --exclude %exclude_pattern% "%asterisk_arg%" &goto :checkoutput 
if %isdir% == 1 if "%exclude_pattern%" == "" if %asterisk%==1 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% "%asterisk_arg%"&tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%"  --format %format-choice% "%asterisk_arg%"&goto :checkoutput
if %isdir% == 1 if "%exclude_pattern%" NEQ "" echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% --exclude %exclude_pattern% "%fl_nm%" &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% --exclude %exclude_pattern% "%fl_nm%"  
if %isdir% == 1 if "%exclude_pattern%" == "" echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% "%fl_nm%"&tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%"  --format %format-choice% "%fl_nm%" 
if %isdir% == 0 if "%exclude_pattern%" NEQ "" echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% --exclude %exclude_pattern% "%fl_nm_only%"  &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% --exclude %exclude_pattern% "%fl_nm_only%"  
if %isdir% == 0 if "%exclude_pattern%" == "" echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% "%fl_nm_only%"&tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%"  --format %format-choice% "%fl_nm_only%"  
:checkoutput
set /a program_error_level=%errorlevel%
if %program_error_level%==0 (if exist "%fl_nm_only%%RAND%%archive-extension%" (echo:&echo Output File: "%fl_nm_only%%RAND%%archive-extension%"&move "%fl_nm_only%%RAND%%archive-extension%" "%current_dir%"&call :seterror 0&cd "%current_dir%") else (call :seterror 1)) else (call :seterror 1)
echo:tar[%program_error_level%]*******"%~nx0"[%errorlevel%]   ^(Error codes:1=Fail^)
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
goto :eof
:printversion
certutil -hashfile "%~fp0" md5