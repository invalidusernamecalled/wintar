@echo off
set "wrkdir=%cd%"
set inpt_fle=
set inpt_dir=
set extensionset=0
call :seterror 1
if "%~2"=="/f" (cd /d "%~3" >NUL&echo "%~fp1"&goto :eof)
if "%~2"=="/n" (cd /d "%~3" >NUL&echo "%~nx1"&goto :eof)
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
if "%~2" NEQ "" set exclude_pattern=--exclude "%~2"
if "%~3" NEQ "" set exclude_pattern=%exclude_pattern% --exclude "%~3"
if "%~4" NEQ "" set exclude_pattern=%exclude_pattern% --exclude "%~4"
if "%~5" NEQ "" set exclude_pattern=%exclude_pattern% --exclude "%~5"
if "%~6" NEQ "" set exclude_pattern=%exclude_pattern% --exclude "%~6"
if "%~7" NEQ "" set exclude_pattern=%exclude_pattern% --exclude "%~7"
if "%~8" NEQ "" set exclude_pattern=%exclude_pattern% --exclude "%~8"
if "%~9" NEQ "" set exclude_pattern=%exclude_pattern% --exclude "%~9"
if not exist "%tempname%" echo:File not exist & call :seterror 9009 & goto :eof
set /a file=1
if exist "%~1\*" set /a file=0
if %file%==0 (echo argument is a directory&set /a isdir=0) else (echo argument is a file&set /a isdir=1)
if exist "%tempname%" echo "%tempname%" exists.&goto fileexistfinish
goto :eof
:fileexistfinish
call :seterror 0
set /a asterisk=0
set asterisk_arg=
set /a start=1
echo "%~1"|findstr /r "[*]"&&goto :asterisk
goto process
:asterisk
set /a asterisk=1
set /a start+=1
echo:searching for *
for /f "tokens=%start% delims=\" %%i in ("%~1") do echo searching:"%%i"&echo "%%i"|findstr /r "[*]"&&set "asterisk_arg=%%i"
if %start% GTR 254 goto secondtry
if "%asterisk_arg%" == "" goto asterisk
:secondtry
echo "%~1"|findstr /r "[*]"&&set "asterisk_arg=%~1"
:process
set /a isroot=0
if %asterisk%==1 for /f "delims=" %%i in ('dir /b "%tempname%"') do set "fl_nm_only=%%~i"&goto continuenext
if %isdir% == 1 for /f "delims=" %%i in ('dir /a-d /b "%tempname%"') do set "fl_nm_only=%%~i"&goto continuenext
if %isdir% == 0 for /f "delims=" %%i in ('echo:^&"%~fp0" "%tempname%" /n "%wrkdir%"') do set "fl_nm_only=%%~i"
if %isdir% == 0 for /f "delims=" %%i in ('echo:^&"%~fp0" "%tempname%\.." /n "%wrkdir%"') do if "%%~i"=="" set /a isroot=1
:continuenext
if %isroot%==1 echo :IS ROOT?!
for /f "delims=" %%i in ('echo:^&"%~fp0" "%tempname%\.." /f "%wrkdir%"') do set "inpt_dir=%%~i"&set "fl_nm=%%~i"
REM set last_letter=
REM :rejig1
REM set "last_letter=%inpt_dir:~-1,1%"
REM if "%last_letter%"=="\" (set "inpt_dir=%inpt_dir:~0,-1%")
REM set "last_letter=%inpt_dir:~-1,1%"
REM if "%last_letter%"=="\" (goto rejig1)
echo:directory:"%inpt_dir%":will change to it before processing.
echo:
REM set last_letter=
REM :rejig2
REM set "last_letter=%fl_nm:~-1,1%"
REM if "%last_letter%"=="\" (set "inpt_dir=%fl_nm:~0,-1%")
REM set "last_letter=%inpt_dir:~-1,1%"
REM if "%last_letter%"=="\" goto rejig2
if %asterisk%==1 echo:target name only:"%asterisk_arg%"
if %asterisk%==1 echo FULL TARGET NAME: "%inpt_dir%\%asterisk_arg%"&goto :leavetargetprint
if %isroot%==0 echo:target name only:"%fl_nm_only%"
if %isroot%==0 echo FULL TARGET NAME: "%inpt_dir%\%fl_nm_only%"
if %isroot%==1 echo:target name only:
if %isroot%==1 echo:FULL TARGET NAME:%inpt_dir%
:leavetargetprint
set "current_dir=%cd%"
set probcur=0
set /a timetochuck=0
if /i "%format-choice%"=="shar" set archive-extension=.shar
:regen
set /a timetochuck+=1
set /a RAND=%RANDOM%*9999/32767
echo:Trying archive name:"%fl_nm_only%%RAND%%archive-extension%"
if %timetochuck% GTR 250 echo:Failed & goto :eof
if exist "%inpt_dir%\%fl_nm_only%%RAND%%archive-extension%" goto regen
if exist "%current_dir%\%fl_nm_only%%RAND%%archive-extension%" goto regen
if exist "%userprofile%\desktop\%fl_nm_only%%RAND%%archive-extension%" goto regen
set /a timetochuck=0
:reGhig
set /a timetochuck+=1
if %timetochuck% GTR 100 goto ZZig
for /f "delims=" %%i in ('where cmd') do set "bakra=%%i"
copy "%bakra%" "%fl_nm_only%%RAND%%archive-extension%" 2>NUL 1>NUL
if %errorlevel%==0 del "%fl_nm_only%%RAND%%archive-extension%" 2>NUL&echo:Can write to current directory&goto ZZig
if %errorlevel% NEQ 0 echo Problems writing file in current directory.&set /a probcur=1
echo:will save to desktop
cd /d "%userprofile%\desktop"
set "current_dir=%cd%"
:ZZig
set fl_nm_only_args=
if "%fl_nm_only%" NEQ "" set "fl_nm_only_args=\%fl_nm_only%"
if %isroot%==1 goto :istoor
if %probcur%==1 if %asterisk%==1 goto manage
if %asterisk%==1 goto manage
pushd "%inpt_dir%"&goto :checkdirclown
if %isdir%==1 if %targetyes% neq 1 popd
if %isdir%==1 if %probcur% neq 0  popd
:All_is_Well
if %isdir%==1 if %asterisk%==1 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%asterisk_arg%" &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%asterisk_arg%" &goto :checkoutput 

if %isdir%==1 if %targetyes%==1 if %probcur%==0 pushd "%inpt_dir%"&echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%fl_nm_only%" &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%fl_nm_only%"&goto :checkoutput

if %isdir%==1 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%inpt_dir%\%fl_nm_only%" &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%inpt_dir%\%fl_nm_only%"  

if %isdir%==0 if %probcur%==1 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%fl_nm_only%"  &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%inpt_dir%%fl_nm_only_args%" &goto checkoutput 

if %isdir%==0 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%fl_nm_only%"  &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%fl_nm_only%"  

  
:checkoutput
echo:
echo:Output directory:"%current_dir%"
set /a program_error_level=%errorlevel%
if %program_error_level%==0 (if exist "%fl_nm_only%%RAND%%archive-extension%" (echo:&echo Output File: "%fl_nm_only%%RAND%%archive-extension%"&move "%fl_nm_only%%RAND%%archive-extension%" "%current_dir%"&call :seterror 0&cd /d "%current_dir%") else (call :seterror 1))
if %program_error_level% NEQ 0  if exist "%fl_nm_only%%RAND%%archive-extension%" echo:Output File: "%fl_nm_only%%RAND%%archive-extension%"&call :seterror 0&cd /d "%current_dir%"
echo:tar[%program_error_level%]*******"%~nx0"[%errorlevel%]   ^(Error codes:1=Fail^)
if %program_error_level% NEQ 0  if exist "%fl_nm_only%%RAND%%archive-extension%" for /f "delims=" %%I in ('tar -t -f "%fl_nm_only%%RAND%%archive-extension%" ^| find /c /v ""') do echo:tar returned some errors. & if %%I==0 echo FATAL FLAW:file may be corrupt.&call :seterror 2

goto :eof
:manage
if %probcur%==0 if "%cd%"=="%inpt_dir%" echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%asterisk_arg%" &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%asterisk_arg%" &goto :checkoutput

if %isdir%==1 if %asterisk%==1 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%inpt_dir%\%asterisk_arg%" &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%inpt_dir%\%asterisk_arg%" &goto :checkoutput 
goto :eof
:istoor
set drive_letter=%fl_nm:~0,1%
echo It is %drive_letter%:
echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%drive_letter%:\*"  &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%drive_letter%:\*"
goto checkoutput
goto :eof
:checkdirclown
:regenrate
set /a targetyes=0
set /a timetochuck+=1
if %timetochuck% GTR 100 goto All_is_Well
for /f "delims=" %%i in ('where cmd') do set "bakra=%%i"
copy "%bakra%" "%fl_nm_only%%RAND%%archive-extension%" 2>NUL 1>NUL
if %errorlevel%==0 set /a targetyes=1&goto All_is_Well
if %errorlevel% NEQ 0 echo Problems writing file in target's directory.
del "%fl_nm_only%%RAND%%archive-extension%"
popd

if %isdir% == 0 echo:tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%inpt_dir%%fl_nm_only_args%"  &tar %createparam% -f "%fl_nm_only%%RAND%%archive-extension%" --format %format-choice% %exclude_pattern% "%inpt_dir%%fl_nm_only_args%"  

goto checkoutput
:seterror
exit /b %1
:printhelp
if "%~1"=="/?" echo WinTarrer v1.4  [by Puneet Bapna]
echo:
echo:                     (environment variables) Wildcards=* Not supported=?
echo:--^>set archive-choice=[{default=}.tar^|.tar.gz^|.tar.bz2^|.tar.xz^|.tar.lzma]
echo:--^>set format-choice=[{default=}ustar^|pax^|cpio^|shar]
echo:
echo Syntax:-
echo "%~nx0" "Directory/File To Add to archive" [exclude_pattern1/optional] .. [exclude_pattern8/optional]
echo:

echo archive name is auto-generated. does not add to existing archive.
echo:
call :seterror 0
goto :eof
:printversion
call :seterror 0
certutil -hashfile "%~fp0" md5