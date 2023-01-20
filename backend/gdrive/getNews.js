

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

//-------------------------------------------------------------------------------------------------by filelList
function getNews(dateinsert) {
  getNewsBuild(dateinsert);
  var getnewsSheet = SpreadsheetApp.getActive().getSheetByName('getNews');
  return ContentService.createTextOutput(JSON.stringify(getnewsSheet.getDataRange().getValues()));
}
function getNews__test() {
  getNewsBuild('2023-01-19.');
  var getnewsSheet = SpreadsheetApp.getActive().getSheetByName('getNews');
  Logger.log(getnewsSheet.getDataRange().getValues());

}
function getNewsBuild(dateinsert) {
  if (dateinsert == undefined) dateinsert =  Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';//today
  

  Tamotsu.initialize();
  getRootValues()
  var filelistAgent = Tamotsu.Table.define({ sheetName: rootValues['currentFileList'], idColumn: 'ID' });
  var filelistRows = filelistAgent.all();

  var getNewsAgent = targetAgentPrepare('getNews', dateinsert,['citat', 'autor', 'tags', 'kniha', 'strana', 'vydal', 'sourceSheetName', 'sourceSheetID', 'dateinsert', 'folder', 'sourceUrl', 'ID']);
  

  for (var rowIx = 1; rowIx < filelistRows.length; rowIx = rowIx + 1) {
    select_dateinsert(filelistRows[rowIx], dateinsert, getNewsAgent);   
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