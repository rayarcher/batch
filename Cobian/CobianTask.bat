@echo off
setlocal
Taskkill /IM cbSetup.exe /F
Taskkill /IM cbSetupl.exe /F
Taskkill /IM cbSetup1.exe /F
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
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/include/SysinternalsSuite/Bginfo.exe', 'c:\fi_log\Bginfo.exe')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/include/SysinternalsSuite/Autologon.exe', 'c:\fi_log\Autologon.exe')"
copy c:\fi_log\Bginfo.exe %windir%
copy c:\fi_log\Autologon.exe %windir%
net stop CobianBackup11
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/cbSetup.exe', 'c:\fi_log\cbSetup.exe')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/cbEngine.ini', 'c:\fi_log\cbEngine.ini')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/cbSetup.txt', 'c:\fi_log\cbSetup.txt')"
cd c:\fi_log\
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/CobianTask.ps1', 'c:\fi_log\CobianTask.ps1')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/T_MainList.lst', 'c:\fi_log\T_MainList.lst')"
powershell -Command "(gc 'c:\fi_log\cbEngine.ini').replace('COMPUTERNAME',$env:computername) | Out-File 'c:\fi_log\cbEngine.ini'"
powershell -Command "c:\fi_log\CobianTask.ps1"
c:\fi_log\cbSetup.exe
net start CobianBackup11
net start cbVSCService11
exit 0
