@echo Export policy to text file
	secedit /export /cfg c:\secpol.cfg
	powershell -Command "(gc C:\secpol.cfg).replace('PasswordComplexity = 1', 'PasswordComplexity = 0') | Out-File C:\secpol.cfg"
	powershell -Command "(gc C:\secpol.cfg).replace('MaximumPasswordAge = 42', 'MaximumPasswordAge = -1') | Out-File C:\secpol.cfg"
	secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
	powershell -Command "rm -force c:\secpol.cfg -confirm:$false"
	rem del /F /S /Q c:\secpol.cfg
net accounts /MaxPWAge:unlimited
net user archer gluckomania /add /expires:never /FULLNAME:"��㦥���� ��⭠� ������"
net localgroup Administrators archer /add
net localgroup ������������ archer /add
net localgroup Users archer /delete
net localgroup ���짮��⥫� archer /delete
net user archer /Expires:Never

net user support support /add /expires:never /FULLNAME:"��㦥���� support"
net localgroup Administrators support /add
net localgroup ������������ support /add
net localgroup Users support /delete
net localgroup ���짮��⥫� support /delete
net user support /Expires:Never
