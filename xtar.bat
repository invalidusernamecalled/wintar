@echo off
if Not exist "%~1" echo:File not exist&goto :printhelpmenu
set /a maxxtri=0
set "fl_nm=%~fp1"
set "fl_nm_only=%~n1"
set "archive-choice=%~x1"
set /a extensionfound=0
if defined archive-choice for %%a in (.tar .tar.gz .tar.bz2 .tar.xz .tar.lzma) do if /i "%archive-choice%"=="%%a" (set /a extensionfound=1)
if %extensionfound%==1 goto next
choice /c yn /m "does not seem to be valid extension. do u want to still try (default=n)" /d n /t 2
if %errorlevel%==2 goto :eof
:next
set /a foldcount=0
if "%~2"=="/s" for /f "delims=" %%i in ('tar -t -f "%~1" ^| findstr /r "[/]$" ^| find /c /v ""') do set /a foldcount=%%i
if "%~2"=="/s" if %foldcount%==1 set check=&set /a start=1 & goto foldset
goto regen
:foldset
for /f "tokens=%start% delims=/" %%i in ('tar -t -f "%~1" ^| findstr /r "[/]$" ') do set "dirofconcern=%%i"&set "check=%%i"
if "%check%"=="" goto regen
set check=
set /a start+=1
if %start% GTR 254 echo:Fail too many long path & goto :eof
:regen
set /a maxxtri+=1
set /a RAND=%RANDOM%*9999/32767
echo:Trying folder name:"%fl_nm_only%%RAND%"
if %maxxtri% GTR 250 echo:Unable to find unique name for folder&goto :eof
if exist "%fl_nm_only%%RAND%" goto regen
mkdir "%fl_nm_only%%RAND%"
if not exist "%fl_nm_only%%RAND%" echo:unable make folder & goto :eof
if exist "%fl_nm_only%%RAND%" pushd "%fl_nm_only%%RAND%" & copy "%fl_nm%" .\
if exist "%fl_nm_only%%archive-choice%" tar -x -f  "%fl_nm_only%%archive-choice%"
echo|set/p=tar[%errorlevel%]
del  "%fl_nm_only%%archive-choice%"
if exist "..\%fl_nm_only%%RAND%" popd
if "%~2"=="/s" if %foldcount%==1 if exist "%fl_nm_only%%RAND%" pushd "%fl_nm_only%%RAND%" & move "%dirofconcern%\*" .\ 1>NUL & rd "%dirofconcern%" & popd
goto :eof
:printhelpmenu
echo:Tar extracter v.1
echo:"%~nx0" "archive-name[.tar|.tar.gz|.tar.bz2|.tar.xz|.tar.lzma]"