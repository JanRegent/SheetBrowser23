

function starredAppend(rowValue) {

  var rowStr = decodeURI(rowValue);
  var starredLink = rowStr.split('__|__');

  var sheetName = starredLink[0].replace('sheetName|','');
  var sourceFileId = starredLink[2].replace('fileId|','');

  Tamotsu.initialize(SpreadsheetApp.openById(sourceFileId));
  var sourceAgent =    Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' });
  var sourceRow = sourceAgent.find(parseInt(starredLink[1].replace('ID|','')))

  Tamotsu.initialize();
  var starredAgent =    Tamotsu.Table.define({ sheetName: 'starred2022', idColumn: 'ID' });

  createRow2(starredAgent, sourceRow, sourceFileId, sourceSheetName);

  return ContentService.createTextOutput(JSON.stringify({action: "starredAppend", result: "OK-starred"}));

}

var todecode = 'sheetName%7CdailyNotes__%7C__ID%7C384__%7C__fileId%7C1oklmBpFWHAUCU4nPpNUMOQAZ0jIA1U_zfVtIWxHhBG0';

function starredAppend__test() {
  starredAppend(todecode)
  
}


function createRow2(targetAgent, sourceRow, fileId, sourceSheetName) {

  var cols = ['citat', 'autor', 'tags', 'kniha', 'strana', 'vydal', 'sourceSheetName', 'sourceSheetID', 'dateinsert','sourceUrl'];
  for (var colIx = 0; colIx < cols.length; colIx = colIx + 1) {
    value = sourceRow[cols[colIx]] 
    if (value != null) continue;
    sourceRow[cols[colIx]] = '';
  }
 
  try {

    targetAgent.create({
      'citat': sourceRow['citat'],
      'autor': sourceRow?.autor ?? '',
      'tags': sourceRow?.tags ?? '',
      'kniha': sourceRow?.kniha ?? '',
      'strana': sourceRow?.strana ?? '',
      'vydal': sourceRow?.vydal ?? '',
      'sourceSheetName': sourceSheetName,
      'sourceSheetID': sourceRow?.ID ?? '',
      'sourceFileId': fileId,
      'dateinsert': sourceRow?.dateinsert ?? '',
      'sourceUrl': sourceRow?.sourceUrl ?? '',

    });
  }catch(e){
      Logger.log(targetAgent.sheetName + '  ' +e.toString())
  }

}