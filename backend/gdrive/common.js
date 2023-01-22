
var rootValues = {}

function getRootValues() {
  var rootSheet = SpreadsheetApp.getActive().getSheetByName('rootSheet');
  var values = rootSheet.getDataRange().getValues();
  for (var rowIx = 1; rowIx < values.length; rowIx = rowIx + 1) {
    if (values[rowIx][0].toString().trim()== '') continue;
    rootValues[values[rowIx][0]] = values[rowIx][1];
  }
}



function logi(e) {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('log')
  logsheet.appendRow([new Date(), e])
}
function logclear() {
  var logsheet = SpreadsheetApp.getActive().getSheetByName('log')
  logsheet.clear()
}