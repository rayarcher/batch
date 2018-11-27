@echo off
setlocal
SET mypath=%~dp0
echo %mypath:~0,-1%
set sourcedir=%mypath:~0,-1%\Bginfo
set destinationdir=c:\deploys\Bginfo
set destinationdir1=c:\Bginfo
echo This file:
Echo Copy Bginfo folder from  %sourcedir% to %destinationdir% and %destinationdir1% and add autorun registry record to all users
Echo owerwrite all files in destination folder

goto :begin
:action
    echo Action here
    copy %sourcedir%\*.* %destinationdir%\*.* /V /Y /Z
    copy %destinationdir%\*.* %destinationdir1%\*.* /V /Y /Z
    reg import %destinationdir1%\Autorun_bginfo.reg
    start %destinationdir1%\Bginfo64.exe %destinationdir1%\default.bgi /accepteula /silent /timer:0
    exit /b
goto :eof

:nopath
    echo %1 %2 path not exist
    if [%1] == [Source] (
        echo Source not exist
        exit /b
        goto :eof
    )
    if [%1] == [Destination] (
        echo Try to create %2
        if not exist %2 (
            mkdir %2
            exit /b
            goto :eof
        )
    ) 
    if [%1] == [Destination1] (
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

:checkdestination1
    if exist %1 ( 
            Echo Destination1 %1 - check sucess
            call :action 
        ) else ( 
            call :nopath Destination1 %1
            call :checkdestination1 %1
        )
    exit /b
goto :eof

:checkdestination
    if exist %1 ( 
            Echo Destination %1 - check sucess
            call :checkdestination1 %2
        ) else ( 
            call :nopath Destination %1
            call :checkdestination %1 %2
        )
    exit /b
goto :eof

:checks
    if exist %1 (
            Echo Source %1 - check sucess
            call :checkdestination %2 %3
        ) else ( 
            call :nopath Source %1
            call :checks %1 %2 %3
        )
    exit /b
goto :eof
:begin

call :checks %sourcedir% %destinationdir% %destinationdir1%

:end
