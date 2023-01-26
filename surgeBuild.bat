

call  .\buildweb.bat

copy web\rssdaily.json build\web\appConfig.json
copy web\rssdaily.json build\web\assets\appConfig.json
call surge c:\dev\SheetViewer\sheetBrowse\SheetBrowse23\build\web --domain SheetBrowser23.surge.sh
rem -----pbrunton-----
copy web\pbrunton.json build\web\appConfig.json
copy web\pbrunton.json build\web\assets\appConfig.json
call surge c:\dev\SheetViewer\sheetBrowse\SheetBrowse23\build\web --domain PaulBrunton.surge.sh



