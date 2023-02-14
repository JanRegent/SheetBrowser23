

function newRowsGet() {
  appRootDataValuesLoad() 
  logclear();

  var dateinsert =  Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';
  logi('newRowsGet() ' +  dateinsert)
  var newRowsSheet  = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('newRows');

  var filelistSheet  = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(appRootData['currentFileList']);
  var filelistRows = filelistSheet.getDataRange().getValues();


  for (var rowIx = 1; rowIx < filelistRows.length; rowIx = rowIx + 1) {
    newSheetRowsAdd(newRowsSheet, filelistRows[rowIx], dateinsert);
  }
}

function newSheetRowsAdd(newRowsSheet, row, dateinsert){
  var sheetName = row[0];
  var sourceSheet = SpreadsheetApp.openByUrl(row[1]).getSheetByName(sheetName)
  var rows =   sourceSheet.getDataRange().getValues();
  var cols = rows[0];
  var posDateinsert = cols.indexOf('dateinsert') ;
  if (posDateinsert==-1) return;
  var posID = cols.indexOf('ID');
  if (posID==-1) return;
  for (var rowIx = rows.length-1; rowIx > 0; rowIx = rowIx - 1) {
    if (rows[rowIx][posDateinsert] != dateinsert) return;
    newRowsSheet.appendRow([sheetName,rows[rowIx][posID],dateinsert ]);
  }
 
}

