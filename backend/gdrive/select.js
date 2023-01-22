


//----------------------------------------------------------------------------------------------------selectWhere
function selectWhere1(sheetName, columnName, operator, value) {
 

  var sourceSheet = SpreadsheetApp.getActive().getSheetByName(sheetName);
  var columnLetter = columnName2columnLetter(sourceSheet, columnName);
  var source = '=QUERY('+ sheetName +  '!A1:'+ columnLetter ;
  var select = '"select * where '+ columnLetter +' like \'%'+value+'%\' "';
Logger.log(source + ',' + select + ',1)');
  var temp = SpreadsheetApp.getActive().getSheetByName('temp');
  temp.clear();
  temp.getRange('A1:A1').setValue(source + ',' + select + ',1)') ;

  return ContentService.createTextOutput(JSON.stringify(temp.getDataRange().getValues()));
}

function selectWhere1__test() {
  Logger.log(selectWhere1('starred2022', 'dateinsert', 'contains', '2022-10-31.'));
}



//---------------------------------------------------------------------------------uti
function columnName2columnLetter(sourceSheet, columnName) {
  var header = sourceSheet.getDataRange().getValues()[0];
  var index = header.indexOf(columnName);
  if (index < 0) return ''; 
  return columnLetter(index+1);
}
function columnLetter(index) {
    var cname = String.fromCharCode(65 + ((index - 1) % 26));
    if (index > 26)
        cname = String.fromCharCode(64 + (index - 1) / 26) + cname;
    return cname;
}