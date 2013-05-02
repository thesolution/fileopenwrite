CONSOLE APPLICATION : fileopenwrite Project Overview
====================================================
## Overview 
Test program to verify LogStash Windows issue.  This program attempts to opens a file with SharedMode=0(Exclusive lock)
and writes a log message a couple times

The test attempts to creat/open a file with an exclusive OS lock, write  to the file and close.
The test then attempts to delete the file from disk.

## Instructions

To run the test first verify the logstash monolithic jar exists in the current directory

Run the logstash.cmd
```bat
c:\>cd \git\fileopenwrite
c:\git\fileopenwrite>logstash.cmd
```

Once logstash has finished opening test by entering a message in stdin.

Now open a new shell.

```bat
c:\>cd \git\fileopenwrite
c:\git\fileopenwrite>fileopenwrite.cmd
```


## Output from logstash.bat
```bat

C:\git\fileopenwrite>c:

C:\git\fileopenwrite>cd \git\fileopenwrite

C:\git\fileopenwrite>rem set HOME=c:\git\fileopenwrite\sincedb

C:\git\fileopenwrite>rem set CloseAfterRead=true

C:\git\fileopenwrite>"c:\Program Files\Java\jre7\bin\java.exe" -jar logstash-1.1.10.dev-monolithic2.jar agent -f logstash.conf
start
{
         "@source" => "stdin://RI-ENG-229/",
           "@tags" => [],
         "@fields" => {},
      "@timestamp" => "2013-05-02T21:11:42.241Z",
    "@source_host" => "RI-ENG-229",
    "@source_path" => "/",
        "@message" => "start",
           "@type" => "human"
}
{
       "@source" => "file://RI-ENG-229/C:\\git\\fileopenwrite\\blocked.log",
         "@tags" => [],
       "@fields" => {},
    "@timestamp" => "2013-05-02T21:11:59.642Z",
      "@message" => "to write to the file.\r",
         "@type" => "blocked"
}
```



## Output from fileopenwrite.bat
```bat
C:\git\fileopenwrite>rm blocked.log

C:\git\fileopenwrite>echo fileopenwrite will write n messages to the log file starting from position 0
fileopenwrite will write n messages to the log file starting from position 0

C:\git\fileopenwrite>Debug\fileopenwrite.exe blocked.log 1

Writing 46 bytes to blocked.log.
Wrote 46 bytes to blocked.log successfully.

C:\git\fileopenwrite>echo Now start the logstash.cmd
Now start the logstash.cmd

C:\git\fileopenwrite>pause
Press any key to continue . . .

C:\git\fileopenwrite>Debug\fileopenwrite.exe blocked.log 3

ERROR: CreateFile failed with error code 32 as follows:
The process cannot access the file because it is being used by another process.

Terminal failure: Unable to open file "blocked.log" for write.

C:\git\fileopenwrite>echo Deleting the log file
Deleting the log file

C:\git\fileopenwrite>pause
Press any key to continue . . .

C:\git\fileopenwrite>del blocked.log
C:\git\fileopenwrite\blocked.log
The process cannot access the file because it is being used by another process.

C:\git\fileopenwrite>pause
Press any key to continue . . .
```

# Conclusion
The output from the fileopenwrite.bat file clearly does not exhibit the correct behavior.
The Errors
```
ERROR: CreateFile failed with error code 32 as follows:
The process cannot access the file because it is being used by another process.
```
And
``` 
The process cannot access the file because it is being used by another process.
```

Show that log stash does not release the file reader lock until the process stops running.
Rolling log appenders and loggers that attempt to obtain exclusive access will fail to operate properly when logstash monitors them.