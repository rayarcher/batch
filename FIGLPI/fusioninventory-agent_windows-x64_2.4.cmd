fusioninventory-agent_windows-x64_2.4.exe /acceptlicense /add-firewall-exception /S /execmode=Service /installtasks=Full /runnow /task-frequency=Minute /task-minute-modifier=15 /conf-reload-interval=60 /httpd-trust='0.0.0.0/0' /server='http://172.16.0.252/plugins/fusioninventory/' /scan-homedirs /p2p /scan-profiles
