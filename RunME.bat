@echo off
setlocal
rem Taskkill /IM cbSetup.exe /F
rem Taskkill /IM cbSetupl.exe /F
rem Taskkill /IM cbSetup1.exe /F
@echo Disable APIPA subsystem
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v ArpRetryCount /t REG_DWORD /d 00000000 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v IPAutoconfigurationEnabled /t REG_DWORD /d 00000000 /f
@echo Disable UAC subsystem
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
@echo Disable windows Firewall and all connection set to Private
PowerShell -Command "Get-NetConnectionProfile"
PowerShell -Command "Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private"
start netsh advfirewall set allprofiles state off
PowerShell -Command "Get-NetConnectionProfile"

secedit /export /cfg c:\secpol.cfg
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force"
powershell -Command "(gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg"
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
del /F /S /Q c:\secpol.cfg

rem powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/include/SysinternalsSuite/Bginfo.exe', 'c:\fi_log\Bginfo.exe')"
rem powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/include/SysinternalsSuite/Autologon.exe', 'c:\fi_log\Autologon.exe')"
rem copy c:\fi_log\Bginfo.exe %windir%
rem copy c:\fi_log\Autologon.exe %windir%
rem net stop CobianBackup11
REM powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/cbSetup.exe', 'c:\fi_log\cbSetup.exe')"
REM powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/cbEngine.ini', 'c:\fi_log\cbEngine.ini')"
REM powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/cbSetup.txt', 'c:\fi_log\cbSetup.txt')"
REM cd c:\fi_log\
REM powershell -Command "(gc 'c:\fi_log\cbEngine.ini').replace('COMPUTERNAME',$env:computername) | Out-File 'c:\fi_log\cbEngine.ini'"
REM c:\fi_log\cbSetup.exe
REM net start CobianBackup11
REM net start cbVSCService11
exit 0
