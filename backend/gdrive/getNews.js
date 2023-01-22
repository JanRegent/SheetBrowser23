



//-------------------------------------------------------------------------------------------------by filelList
function getNews(dateinsert) {
 
  try {
    getNewsBuild(dateinsert);
  }catch(e) {
    logi(e.toString())
  }
  
  var getnewsSheet = SpreadsheetApp.getActive().getSheetByName('getNews');
  return ContentService.createTextOutput(JSON.stringify(getnewsSheet.getDataRange().getValues()));
}
function getNews__test() {
  logclear();
  getNewsBuild('2023-01-22.');
  var getnewsSheet = SpreadsheetApp.getActive().getSheetByName('getNews');
  Logger.log(getnewsSheet.getDataRange().getValues());

}
function getNewsBuild(dateinsert) {
  if (dateinsert == undefined) dateinsert =  Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';//today
  logi(dateinsert)

  Tamotsu.initialize();
  getRootValues()
  var filelistAgent = Tamotsu.Table.define({ sheetName: rootValues['currentFileList'], idColumn: 'ID' });
  var filelistRows = filelistAgent.all();

  var getNewsAgent = targetAgentPrepare('getNews', dateinsert,starredNewsHeader);
  

  for (var rowIx = 1; rowIx < filelistRows.length; rowIx = rowIx + 1) {
    logi(filelistRows[rowIx]['sheetName'])
    select_dateinsert(filelistRows[rowIx], dateinsert, getNewsAgent);   
  }
}


function select_dateinsert(filelistRow, dateinsert, targetAgent) {

  var link2fileId = SpreadsheetApp.openByUrl(filelistRow['fileUrl']).getId();
  Tamotsu.initialize(SpreadsheetApp.openById(link2fileId));
  var sourceAgent =    Tamotsu.Table.define({ sheetName: filelistRow['sheetName'], idColumn: 'ID' });

  var rows = sourceAgent.where({ dateinsert: dateinsert })
     .order(dateinsert)
     .all(); 
  logi('rows ' + rows.length.toString())
  for (var rowIx = 0; rowIx < rows.length; rowIx = rowIx + 1) {     
     appendRowNewsStarred(targetAgent, rows[rowIx], filelistRow['sheetName'], rows[rowIx]['ID'], link2fileId);
  }
}

function targetAgentPrepare(targetSheetName, dateinsert, header) {
  var targetSheet = SpreadsheetApp.getActive().getSheetByName(targetSheetName);
  targetSheet.clear();
  targetSheet.appendRow(header);
  var targetAgent = Tamotsu.Table.define({ sheetName: targetSheetName, idColumn: 'ID' });
  targetAgent.create({'citat': '//new rows with date: ' + dateinsert });
  return targetAgent;
}

//-----------------------------------------------------------------------------------------------news at one sheet

// ?action=getNews1&sheetName=starred2022&value=2022-

function getNews1(sheetName, value) {
  selectWhere1(sheetName, 'dateinsert' , 'contains', value)
  var temp = SpreadsheetApp.getActive().getSheetByName('temp');
  return ContentService.createTextOutput(JSON.stringify(temp.getDataRange().getValues()));
}
function getNews1__test() {
  getNews1('starred2022', '2022-10-31.');
  var temp = SpreadsheetApp.getActive().getSheetByName('temp');
  Logger.log(temp.getDataRange().getValues());

}