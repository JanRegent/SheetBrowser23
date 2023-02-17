// ?action=selectWhere&sheetName=starred2022&colLetter=B&value=@Dala
// ??action=selectWhere&sheetName=starred2022&colLetter=A&value=ticho

function doGet(e) {
  logclear()
  var querystring = JSON.stringify(e);
  logi(querystring);
  appRootDataValuesLoad() ;

  var action = e.parameter.action.toString();

  try { 
    // ?action=relAppend&sheetName=PapajiDailyPedia&sheetID=21&selName=*
    if (action == 'relAppend') {
      var result = relAppendDoGet(e);
      return result;
    }

    if (e.parameter.action=='selectWhere') return selectWhere(e);

  }catch(e) {
    return ContentService.createTextOutput( 'Error: runtime error \n\n' + querystring + '\n\n'  +  JSON.stringify(e));
  }
  return ContentService.createTextOutput(  'Error: wrong parametrs \n\n' + querystring );

  
}
//=QUERY(starred2022!A1:H333, "select * where B like '@Dala%' ",1)

