del blocked.log
echo fileopenwrite will write n messages to the log file starting from position 0
Debug\fileopenwrite.exe blocked.log 2
echo Now start the logstash.cmd
pause
Debug\fileopenwrite.exe blocked.log 4

echo Deleting the log file
pause
del blocked.log
pause