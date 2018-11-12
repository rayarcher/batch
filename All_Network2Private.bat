@echo off
@echo All connection set to Private in Windows firewall
	PowerShell -Command "Get-NetConnectionProfile"
	PowerShell -Command "Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private"
