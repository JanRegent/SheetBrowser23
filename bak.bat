
@ECHO off
SET YY=%DATE:~-4%
SET MM=%DATE:~-7,2%
SET DD=%DATE:~-10,2%
ECHO In format DD/MM/YYYY - %DD%-%MM%-%YY%
set builDateTime='%1---%DD%-%MM%-%YY% %TIME%'
echo const buildVersion = %builDateTime%;     > lib\2business_layer\buildversion.dart
echo const appVersion = '%YY%.%MM%';    > lib\2business_layer\appversion.dart 
call bakgit.bat %1 %2
call bakzip.bat %1 %2






