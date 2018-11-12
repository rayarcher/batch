@echo OFF
setLocal EnableDelayedExpansion
set Url=%1
set Url=!Url:http://=!
set Url=!Url:/=,!
set Url=!Url:%%20=?!
set Url=!Url: =?!

call :LOOP !Url!

set FileName=%2
if "%2"=="" set FileName=!FN!

echo.
echo.Downloading: [1;33m%1[0m to [1;33m\!FileName![0m

powershell.exe -Command wget %1 -OutFile !FileName!

goto :EOF
:LOOP
if "%1"=="" goto :EOF
set FN=%1
set FN=!FN:?= !
shift
goto :LOOP
