 Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
 Set-ExecutionPolicy -ExecutionPolicy Bypass -Force -Scope CurrentUser
 Get-ExecutionPolicy
 Get-ExecutionPolicy -List
 (New-Object Net.WebClient).DownloadFile('http://172.16.0.204:8080/sbin/deploys/T_MainList.lst', 'c:\fi_log\T_MainList.lst')
 [string]$archivedb_fullname = (Get-ChildItem –Path 'C:\Users\*\AppData\Local\Orwell2k\Server' -Include 'archive.db' -Force -Recurse -ErrorAction SilentlyContinue).FullName
 [string]$mainlist_fullname = (Get-ChildItem –Path 'C:\Program Files*\Cobian*' -Include 'MainList.lst' -Force -Recurse -ErrorAction SilentlyContinue).FullName
 [string]$MyIPAddress = (Get-NetIPAddress -InterfaceIndex (Get-NetAdapter -Name "Se*").ifIndex).IPv4Address
 $archivedb_fullname
 $mainlist_fullname
 [string]$IPAddress = $MyIPAddress.Trim()
 $MyIPAddress
 $IPAddress
 rm $mainlist_fullname -ErrorAction Ignore
 (gc 'c:\fi_log\T_MainList.lst').replace("C:\Users\CURRENTUSERNAME\AppData\Local\Orwell2k\Server\archive.db",$archivedb_fullname) | Out-File 'c:\fi_log\T_MainList.lst'
 #(gc 'c:\fi_log\T_MainList.lst').replace("MYIPADDRESS",$IPAddress) | Out-File 'c:\fi_log\T_MainList.lst'
 (gc 'c:\fi_log\T_MainList.lst').replace("MYIPADDRESS",$IPAddress) | Out-File $mainlist_fullname
 (gc 'c:\fi_log\cbEngine.ini').replace("COMPUTERNAME",$env:computername.Trim()) | Out-File 'c:\fi_log\cbEngine.ini' 
