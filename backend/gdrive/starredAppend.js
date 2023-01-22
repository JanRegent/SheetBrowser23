

function starredAppend(rowValue) {

  var rowStr = decodeURI(rowValue);
  logi(rowStr);
  var starredLink = rowStr.split('__|__');

  var link2sheetName = starredLink[0].replace('link2sheetName=','');
  var link2fileId = starredLink[2].replace('link2fileId=','');

  try {
    Tamotsu.initialize(SpreadsheetApp.openById(link2fileId));
    var link2Agent =    Tamotsu.Table.define({ sheetName: link2sheetName, idColumn: 'ID' });
    var link2ID = parseInt(starredLink[1].replace('link2ID=',''));
    var sourceRow = link2Agent.find(link2ID)

    Tamotsu.initialize();
    var starredAgent =    Tamotsu.Table.define({ sheetName: 'starred2022', idColumn: 'ID' });

    appendRowNewsStarred(starredAgent, sourceRow, link2sheetName, link2ID, link2fileId);
  }catch(e){
    logi(e.toString())
  }
  return ContentService.createTextOutput(JSON.stringify({action: "starredAppend", result: "OK-starred"}));

}

var todecode = 'link2sheetName=dailyNotes__%7C__link2ID=386__%7C__link2fileId=1oklmBpFWHAUCU4nPpNUMOQAZ0jIA1U_zfVtIWxHhBG0';
//https://script.google.com/macros/s/AKfycbxW_58ScCD9KlM-Ynit_qOtqhpGkV2fPk-enFAZO-so2iH0rI00yWh7R93VSX512Nyrpw/exec?action=starredAppend&starredLink=link2sheetName=dailyNotes__%7C__link2ID=386__%7C__link2fileId=1oklmBpFWHAUCU4nPpNUMOQAZ0jIA1U_zfVtIWxHhBG0

function starredAppend__test() {
  logclear();
  starredAppend(todecode)
  
}

var starredNewsHeader = ['citat', 'autor', 'kniha', 'strana', 'tags', 'dateinsert', 'link2sheetName', 'link2ID', 'link2fileId', 'ID']; 


function appendRowNewsStarred(targetAgent, sourceRow, link2sheetName,link2ID,link2fileId) {

  for (var colIx = 0; colIx < starredNewsHeader.length; colIx = colIx + 1) {
    value = sourceRow[starredNewsHeader[colIx]] 
    if (value == null) sourceRow[starredNewsHeader[colIx]] = '';
    sourceRow[starredNewsHeader[colIx]] = sourceRow[starredNewsHeader[colIx]] 
  }
  sourceRow['link2sheetName'] = link2sheetName;
  sourceRow['link2ID'] = link2ID;
  sourceRow['link2fileId'] = link2fileId;
  try {
    sourceRow['ID'] = targetAgent.max('ID')+1;
    targetAgent.create(sourceRow);
  }catch(e){
      logi('[appendRowStarred] ' + targetAgent.sheetName + '  ' +e.toString())
  }

}