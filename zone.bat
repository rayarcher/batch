@echo off
setlocal
SET mypath=%~dp0
echo %mypath:~0,-1%
set sourcedir=%mypath:~0,-1%\regfiles
set destinationdir=c:\deploys\regfiles
echo This file:
Echo Copy Bginfo folder from  %sourcedir% to %destinationdir% and add autorun registry record to all users
Echo owerwrite all files in destination folder

goto :begin
:action
    echo Action here
    copy %sourcedir%\*.* %destinationdir%\*.*
    REM reg import %destinationdir%\network_trust_zone.reg
    REM reg import %destinationdir%\tvncdesktop.reg
    exit /b
goto :eof
:nopath
    echo %1 %2 path not exist
    if [%1] == [Destination] (
        echo Try to create %2
        if not exist %2 (
            mkdir %2
            call :begin
            exit /b
            goto :eof
        )
    )
    exit /b
goto :eof
:checkdestination
    if exist %1 ( 
            Echo Destination %1 - check sucess
            call :action 
        ) else ( 
            call :nopath Destination %1
        )
    exit /b
goto :eof
:checks
    if exist %1 (
            Echo Source %1 - check sucess
            call :checkdestination %2 
        ) else ( 
            call :nopath Source %1
        )
    exit /b
goto :eof
:begin

call :checks %sourcedir% %destinationdir%
:end