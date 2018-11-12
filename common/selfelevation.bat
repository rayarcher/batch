@echo off 
setlocal enabledelayedexpansion

set CmdDir=%~dp0 
set CmdDir=%CmdDir:~0,-1%

:: Check for Mandatory Label\High Mandatory Level 
whoami /groups | find "S-1-16-12288" > nul 
if "%errorlevel%"=="0" ( 
    echo Running as elevated user.  Continuing script. 
) else ( 
    echo Not running as elevated user. 
    echo Relaunching Elevated: "%~dpnx0" %*

    if exist "%CmdDir%\elevate.cmd" ( 
        set ELEVATE_COMMAND="%CmdDir%\elevate.cmd" 
    ) else ( 
        set ELEVATE_COMMAND=elevate.cmd 
    )

    set CARET=^^ 
    !ELEVATE_COMMAND! cmd /k cd /d "%~dp0" !CARET!^& call "%~dpnx0" %* 
    goto :EOF 
)

:: Continue script here

echo Arguments passed: %*
