
function appendStarDo(e) {
      logi(e.parameter.action)
      var sheetName = e.parameter.sheetName
      var sheetID = e.parameter.sheetID

      return appendStarDo2(sheetName, sheetID);
}


function appendStarDo2(sheetName, sheetID) {
  appRootDataValuesLoad() 

  try {
    logi(sheetName + ' ' + sheetID)

    var selSheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('*')
    if (selSheet == undefined) return;

    selSheet.appendRow([sheetName, sheetID]);
    
  }catch(e){
    logi('appendStarDo2(): '  + e.toString())
  }
  return ContentService.createTextOutput(JSON.stringify({action: "appendStar", result: "OK-appendStar"}));

}


// ?action=relAppend&sheetName=PapajiDailyPedia&sheetID=21&selName=*

function relAppend__test() {
  logclear();
  appendStarDo2('PapajiDailyPedia', 2222)
  
}
