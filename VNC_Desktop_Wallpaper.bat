@echo off
@echo VNC Enable Desktop Walpaper
	reg add HKLM\SOFTWARE\TightVNC\Server /v RemoveWallpaper /t REG_DWORD /d 00000000 /f