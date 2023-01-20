
var rootValues = {}

function getRootValues() {
  var rootSheet = SpreadsheetApp.getActive().getSheetByName('rootSheet');
  var values = rootSheet.getDataRange().getValues();
  for (var rowIx = 1; rowIx < values.length; rowIx = rowIx + 1) {
    if (values[rowIx][0].toString().trim()== '') continue;
    rootValues[values[rowIx][0]] = values[rowIx][1];
  }
}

function createRow(targetAgent, sourceRow) {
  Logger.log(sourceRow);

  try {
    targetAgent.create({
        'citat': sourceRow.citat,
        'autor': sourceRow['autor'],
        'tags': sourceRow['tags'],
        'kniha': sourceRow['kniha'],
        'strana': sourceRow['strana'],
        'vydal': sourceRow['vydal'],
        'sourceSheetName': sourceRow['sourceSheetName'],
        'sourceSheetID': sourceRow['sourceSheetID'],
        'dateinsert': sourceRow['dateinsert'],
        'sourceUrl': sourceRow['sourceUrl'],

      });
    }catch(e){
      Logger.log(sourceSheetName + '  ' +e.toString())
  }

}
