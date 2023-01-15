// ?action=selectWhere&sheetName=starred2022&colLetter=B&value=@Dala
// ??action=selectWhere&sheetName=starred2022&colLetter=A&value=ticho
function doGet(e) {
  var querystring = JSON.stringify(e);
  getRootValues() ;

  try {
    if (e.parameter.action=='selectWhere') return selectWhere(e);
  }catch(e) {
    return ContentService.createTextOutput( 'Error: Runtime error \n\n' + querystring + '\n\n'  +  JSON.stringify(e));
  }
  return ContentService.createTextOutput(  'Error: Missing parametrs \n\n' + querystring );

  
}
//=QUERY(starred2022!A1:H333, "select * where B like '@Dala%' ",1)

function columnLetter(index) {
    var cname = String.fromCharCode(65 + ((index - 1) % 26));
    if (index > 26)
        cname = String.fromCharCode(64 + (index - 1) / 26) + cname;
    return cname;
}

//hledaniList

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

function getNews() {
  var filelistAgent = Tamotsu.Table.define({ sheetName: rootValues['currentFileList'], idColumn: 'ID' });
  var filelistRows = filelistAgent.all();

  var getNewsSheet = SpreadsheetApp.getActive().getSheetByName('getNews');
  getNewsSheet.clear();
  getNewsSheet.appendRow(['ID', 'citat', 'autor', 'tags', 'kniha', 'strana', 'vydal', 'sourceSheetName', 'sourceSheetID', 'dateinsert', 'folder', 'sourceUrl']);
  var getNewsAgent = Tamotsu.Table.define({ sheetName: 'getNews', idColumn: 'ID' });
  var dateinsert =  Utilities.formatDate(new Date(),"GMT",'yyyy-MM-dd') + '.';
  getNewsAgent.create({
        'citat': 'Last rows ' + dateinsert,
      });

  for (var rowIx = 1; rowIx < filelistRows.length; rowIx = rowIx + 1) {
    var listRow = filelistRows[rowIx];
    var sourceFileId = SpreadsheetApp.openByUrl(listRow['fileUrl']).getId();
    Tamotsu.initialize(SpreadsheetApp.openById(sourceFileId));
    var sourceAgent =    Tamotsu.Table.define({ sheetName: listRow['sheetName'], idColumn: 'ID' });
    var sourceRow =  sourceAgent.last();
    try {
     getNewsAgent.create({
        'citat': sourceRow.citat,
        'autor': sourceRow['autor'],
        'tags': sourceRow['tags'],
        'kniha': sourceRow['kniha'],
        'strana': sourceRow['strana'],
        'vydal': sourceRow['vydal'],
        'sourceSheetName': listRow['sheetName'],
        'sourceSheetID': sourceRow['ID'],
        'dateinsert': sourceRow['dateinsert'],
        'sourceUrl': sourceRow['sourceUrl'],

      });
    }catch(e){
Logger.log(listRow['sheetName'] + '  ' +e.toString())
    //  getNewsAgent.create({
    //     'citat': listRow['sheetName'],
    //     'dateinsert': e.toString(),

    //   });

    }

  }
}
function getNews__test() {
  Tamotsu.initialize();
  getRootValues()
  getNews();
}

