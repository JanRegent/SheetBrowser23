// ?action=selectWhere&sheetName=starred2022&colLetter=B&value=@Dala
// ??action=selectWhere&sheetName=starred2022&colLetter=A&value=ticho
// ?action=getNews
function doGet(e) {
  var querystring = JSON.stringify(e);
  getRootValues() ;

  try {
    if (e.parameter.action=='getNews') return getNews();
    if (e.parameter.action=='selectWhere') return selectWhere(e);
  }catch(e) {
    return ContentService.createTextOutput( 'Error: runtime error \n\n' + querystring + '\n\n'  +  JSON.stringify(e));
  }
  return ContentService.createTextOutput(  'Error: wrong parametrs \n\n' + querystring );

  
}
//=QUERY(starred2022!A1:H333, "select * where B like '@Dala%' ",1)

