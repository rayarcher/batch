collector_sidecar_installer.exe /S -SERVERURL=http://172.16.0.254:9000/api -TAGS="windows,iis"

"C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe" -service install

"C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe" -service start
