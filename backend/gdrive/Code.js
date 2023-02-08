// ?action=selectWhere&sheetName=starred2022&colLetter=B&value=@Dala
// ??action=selectWhere&sheetName=starred2022&colLetter=A&value=ticho

function doGet(e) {
  logclear()
  var querystring = JSON.stringify(e);
  logi(querystring);
  getRootValues() ;

  var action = e.parameter.action.toString();

  try { 
    // ?action=starredAppend&sheetName=PapajiDailyPedia&sheetID=2&fileId=1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w
    if (action == 'starredAppend') {
      logi(action)
      var sheetName = e.parameter.sheetName
      var sheetID = e.parameter.sheetID
      var fileId = e.parameter.fileId

      logi(sheetName)
      logi(sheetID)
      logi(fileId)

      var result = starredAppendDo(sheetName, sheetID, fileId );
      return result;
    }

    if (e.parameter.action=='selectWhere') return selectWhere(e);

  }catch(e) {
    return ContentService.createTextOutput( 'Error: runtime error \n\n' + querystring + '\n\n'  +  JSON.stringify(e));
  }
  return ContentService.createTextOutput(  'Error: wrong parametrs \n\n' + querystring );

  
}
//=QUERY(starred2022!A1:H333, "select * where B like '@Dala%' ",1)

