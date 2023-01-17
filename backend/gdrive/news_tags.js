


function getNews() {
  Tamotsu.initialize();
  getRootValues()
   var getNewsSheet = SpreadsheetApp.getActive().getSheetByName('getNews');

  return ContentService.createTextOutput(JSON.stringify(getNewsSheet.getDataRange().getValues()));

}

function getNewsBuild() {
  var filelistAgent = Tamotsu.Table.define({ sheetName: rootValues['currentFileList'], idColumn: 'ID' });
  var filelistRows = filelistAgent.all();

  var dateinsert =  Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';
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

//-----------------------------------------------------------------------------------------------getTags

function tagsIndex() {
  var filelistAgent = Tamotsu.Table.define({ sheetName: rootValues['currentFileList'], idColumn: 'ID' });
  var filelistRows = filelistAgent.all();

  var getTagsSheet = SpreadsheetApp.getActive().getSheetByName('getTags');
  // getTagsSheet.clear();
  // getTagsSheet.appendRow(['tag', 'sourceSheetName', 'targetSheetID', 'targetFileUrl', 'ID']);
  
  
  //------------------------------------------------------------------------restart filelistRow by lastIndexedSheetName
  var lastIndexedSheetName = getTagsValues[getTagsValues.length-1][1];
  var filelistRowIxStart = 1;
  try {
    var filelistRowStart = filelistAgent.where({ sheetName: lastIndexedSheetName}).first();
    filelistRowIxStart = filelistRowStart['ID'] - 2;//reindex rest of last sheet canceled by time limit exception
    if (filelistRowIxStart <= 1) filelistRowIxStart = 1;
  }catch(_) {
    filelistRowIxStart = 1;
  }
  for (var rowIx = filelistRowIxStart; rowIx < filelistRows.length; rowIx = rowIx + 1) {
    //-------------------------------------------------------------------restart at last rowIx
    var rowIxStart = 0;
    try {
      var getTagsValues = getTagsSheet.getDataRange().getValues()
        var rowIxStart = getTagsValues[getTagsValues.length-1][2]
      if (rowIxStart == undefined) 
        rowIxStart = 0;
      else {
        if (lastIndexedSheetName == filelistRows[rowIx]['sheetName'])
          rowIxStart = rowIxStart + 1;  
        else
          rowIxStart = 0;

      }
    }catch(_) {
      rowIxStart = 0;
    }
    
    //---------------------------------------------------------------------do tags index of sheet 
    Logger.log(filelistRows[rowIx]['sheetName'] + ' at row ' + rowIxStart);
    tagsAppend(filelistRows[rowIx], getTagsSheet, rowIxStart);   
  }
}

function tagsAppend(filelistRow, getTagsSheet, rowIxStart) {
  var sourceFileId = SpreadsheetApp.openByUrl(filelistRow['fileUrl']).getId();
  Tamotsu.initialize(SpreadsheetApp.openById(sourceFileId));
  var sheetName = filelistRow['sheetName']
  var sourceAgent =    Tamotsu.Table.define({ sheetName: sheetName, idColumn: 'ID' });

  var rowID = getTagsSheet.getDataRange().getValues().length
  var rows = sourceAgent.all(); 
  for (var rowIx = rowIxStart; rowIx < rows.length; rowIx = rowIx + 1) {
    var tags = '';
    try {
      tags = rows[rowIx].tags.toString().trim();
      if (tags == '') continue;
    }catch(_) {
      continue;
    }

    tagsArr = tags.split(',')
    for (var tagIx = 0; tagIx < tagsArr.length; tagIx = tagIx + 1) {
      var tag = tagsArr[tagIx].trim()
      if (tag == '') continue;
      rowID = rowID + 1;
      getTagsSheet.appendRow([tag, sheetName, rows[rowIx]['ID'], filelistRow['fileUrl'], rowID]);
    }
  }

}




function tagsIndex__test() {
  Tamotsu.initialize();
  getRootValues()
  tagsIndex();
}

