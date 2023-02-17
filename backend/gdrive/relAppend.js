
function relAppendDoGet(e) {
      logi(e.parameter.action)
      var sheetName = e.parameter.sheetName
      var sheetID = e.parameter.sheetID
      var selName = e.parameter.selName;

      return relAppendDo(sheetName, sheetID, selName );
}


function relAppendDo(sheetName, sheetID, selName) {
  appRootDataValuesLoad() 

  try {
    logi(sheetName + ' ' + sheetID)

    var selSheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(selName)
    if (selSheet == undefined) return;

    selSheet.appendRow([sheetName, sheetID]);
    
  }catch(e){
    logi('relAppendDo: '  + e.toString())
  }
  return ContentService.createTextOutput(JSON.stringify({action: "starredAppend", result: "OK-rel Added"}));

}


// ?action=relAppend&sheetName=PapajiDailyPedia&sheetID=21&selName=*

function relAppend__test() {
  logclear();
  relAppendDo('PapajiDailyPedia', 2, '*')
  
}
