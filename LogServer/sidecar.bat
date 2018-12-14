
rem net use K: \\172.16.0.204\StorMP
rem cd "K:\sbin\LogServer agents"
collector_sidecar_installer.exe /S -SERVERURL=http://graylog:9000/api -TAGS="windows,iis"

"C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe" -service install

"C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe" -service start

rem net use K: /delete