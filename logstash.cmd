c:
cd \git\fileopenwrite
rem set HOME=c:\git\fileopenwrite\sincedb
rem set CloseAfterRead=true
"c:\Program Files\Java\jre7\bin\java.exe" -jar logstash-1.1.10.dev-monolithic2.jar agent -f logstash.conf
pause