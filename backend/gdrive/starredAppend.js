
function starredAppendDoGet(e) {
      logi(e.parameter.action)
      var sheetName = e.parameter.sheetName
      var sheetID = e.parameter.sheetID

      return starredAppendDo(sheetName, sheetID );
}


function starredAppendDo(sheetName, sheetID) {
  appRootDataValuesLoad() 
  var dateinsert =  Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';

  try {
    logi(sheetName + ' ' + sheetID)

    var starredSheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('starred2022')
    starredSheet.appendRow([sheetName, sheetID, dateinsert]);
    
  }catch(e){
    logi('starredAppendDo: '  + e.toString())
  }
  return ContentService.createTextOutput(JSON.stringify({action: "starredAppend", result: "OK-starred"}));

}


// ?action=starredAppend&sheetName=PapajiDailyPedia&sheetID=2

function starredAppend__test() {
  logclear();
  starredAppendDo('PapajiDailyPedia', 2)
  
}
