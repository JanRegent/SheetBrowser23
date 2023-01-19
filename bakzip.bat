@echo off
set yy=%date:~-4%
set mm=%date:~-7,2%
set dd=%date:~-10,2%

set MYDATE=---%2__%yy%_%mm%%dd%

del *.7z

C:\uti\7-Zip\7z.exe a %1%-%%MYDATE%  backend\* lib\* test\* web\*.* web\help\*.* docs\* web\appsScript\*.*  pubspec.yaml *.bat *.ps1  -r

echo pCloud----
xcopy *.7z  "P:\backup\sheetBrowser\"  /C /Y


rem call powershell .\bakftp.ps1
del *.7z





