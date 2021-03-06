@echo off
adb nodaemon server
netstat -ano | findstr "5037"
netstat -ano | findstr "5037" > C:\Windows\Temp\adb_restart.log
for /f "delims=" %%i in (C:\Windows\Temp\adb_restart.log) do (
    @echo on
    REM echo %%i
    set line=%%i
    SetLocal EnableDelayedExpansion
    REM echo !line!
    REM //截取末尾5位
    set pid=!line:~-5%!
    REM //替换空格
    set pid=!pid: =!
    REM echo !pid!
    REM //进程号0为系统进程
    if not "!pid!" == "0" (
        taskkill /f /pid !pid!
    )
    @echo off
)
adb shell