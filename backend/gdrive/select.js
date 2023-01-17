
function columnLetter(index) {
    var cname = String.fromCharCode(65 + ((index - 1) % 26));
    if (index > 26)
        cname = String.fromCharCode(64 + (index - 1) / 26) + cname;
    return cname;
}


function selectWhere(e) {
  var sheetName = e.parameter.sheetName;

  var sourceSheet = SpreadsheetApp.getActive().getSheetByName(sheetName);
  var source = '=QUERY('+ sheetName +  '!A1:'+ columnLetter(sourceSheet.getLastColumn()) ;
  var select = '"select * where '+ e.parameter.colLetter+' like \'%'+e.parameter.value+'%\' "';

  var temp = SpreadsheetApp.getActive().getSheetByName('temp');
  temp.clear();
  temp.getRange('A1:A1').setValue(source + ',' + select + ',1)') ;

  return ContentService.createTextOutput(JSON.stringify(temp.getDataRange().getValues()));
}

function select_dateinsert(filelistRow, dateinsert, targetAgent) {

  var sourceFileId = SpreadsheetApp.openByUrl(filelistRow['fileUrl']).getId();
  Tamotsu.initialize(SpreadsheetApp.openById(sourceFileId));
  var sourceAgent =    Tamotsu.Table.define({ sheetName: filelistRow['sheetName'], idColumn: 'ID' });

  var rows = sourceAgent.where({ dateinsert: dateinsert })
     .order(dateinsert)
     .all(); 

  for (var rowIx = 0; rowIx < rows.length; rowIx = rowIx + 1) {
     createRow(targetAgent, rows[rowIx], filelistRow['sheetName'] );
  }
}
