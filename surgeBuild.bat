
@echo off
echo {"rootSheetId": "%1"} > .\web\assets\cfg\rootSheetId.json
echo {"rootSheetId": "%1"} > .\web\assets\assets\cfg\rootSheetId.json

call flutter build web --web-renderer html 
rem --release


echo {"rootSheetId": "%1"} > .\build\web\assets\cfg\rootSheetId.json
echo {"rootSheetId": "%1"} > .\build\web\assets\assets\cfg\rootSheetId.json


call surge .\build\web --domain %2.surge.sh
