@echo off
setlocal enabledelayedexpansion



for /f %%F in ('dir /s /b e:*.inf') do call :proc1 %%F
rem call :proc1 %%FP0
rem | findstr amd64') do echo "myfile is %%F"

rem set md = 'date /T'
rem set md = $(date /t)
rem echo md = %md%

goto :eof

:proc1
set ps1=%1
if not x%ps1:w10=%==x%ps1% call :proc2 %ps1%
exit /b
goto :eof
:proc2
set ps2=%1
if not x%ps2:amd64=%==x%ps2% call :proc3 %ps2%
exit /b
goto :eof
:proc3
set ps3=%1
echo "From proc3 %ps3%"
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %1
exit /b
goto :eof

:myfind
dir /s /b e:*.inf | findstr w10 | findstr amd64
exit /b
:instinf
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 %1
exit /b
goto :eof