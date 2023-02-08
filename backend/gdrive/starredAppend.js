

function starredAppendDo(sheetName, sheetID, fileId) {
  logi(sheetName)
  logi(sheetID)
  logi(fileId)
 logi('---1')
  try {
    Tamotsu.initialize(SpreadsheetApp.openById(fileId));
    var sourceAgent =    Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' });
    var sourceRow = sourceAgent.find(parseInt(sheetID))
 logi(sheetName)
  logi(sheetID)
  logi(fileId)
  logi('---')
    Tamotsu.initialize();
    var starredAgent =    Tamotsu.Table.define({ sheetName: 'starred2022', idColumn: 'ID' });

    createRowStarred(starredAgent, sourceRow, sheetName, sheetID, fileId);
  }catch(e){
    logi(e.toString())
  }
  return ContentService.createTextOutput(JSON.stringify({action: "starredAppend", result: "OK-starred"}));

}

var todecode = 'link2sheetName=PapajiDailyPedia__%7C__link2ID=2__%7C__link2fileId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

// ?action=starredAppend&sheetName=PapajiDailyPedia&sheetID=2&fileId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w

function starredAppend__test() {
  logclear();
  starredAppendDo('PapajiDailyPedia', 2,  '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w')
  
}

var starredNewsHeader = ['citat', 'autor', 'kniha', 'strana', 'tags', 'dateinsert', 'link2sheetName', 'link2ID', 'link2fileId', 'ID']; 


function createRowStarred(targetAgent, sourceRow, sheetName,sheetID,fileId) {
  logi(sheetName)
  logi(sheetID)
  logi(fileId)
  for (var colIx = 0; colIx < starredNewsHeader.length; colIx = colIx + 1) {
    value = sourceRow[starredNewsHeader[colIx]] 
    if (value == null) sourceRow[starredNewsHeader[colIx]] = '';
    sourceRow[starredNewsHeader[colIx]] = sourceRow[starredNewsHeader[colIx]] 
  }
  sourceRow['link2sheetName'] = sheetName;
  sourceRow['link2ID'] = sheetID;
  sourceRow['link2fileId'] = fileId;
  try {
    sourceRow['ID'] = targetAgent.max('ID')+1;
    targetAgent.create(sourceRow);
  }catch(e){
      logi('[appendRowStarred] ' + targetAgent.sheetName + '  ' +e.toString())
  }

}