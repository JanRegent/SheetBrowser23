// ?action=selectWhere&sheetName=starred2022&colLetter=B&value=@Dala
// ??action=selectWhere&sheetName=starred2022&colLetter=A&value=ticho
// ?action=getNews
// ?action=getTagQuote&sourceSheetName=Nisargadatta__tgQuotes&ID=46&fileId=1JJk7OMlA3_qp0re6H_15ugYUj5KP8x3319GUNHEZ0zo
function doGet(e) {
  var querystring = JSON.stringify(e);
  getRootValues() ;

  try { 
    // ?action=starredAppend&starredLink=sheetName%7CdailyNotes__%7C__ID%7C384__%7C__fileId%7C1oklmBpFWHAUCU4nPpNUMOQAZ0jIA1U_zfVtIWxHhBG0
    if (e.parameter.action=='starredAppend') return starredAppend(e.parameter.starredLink);
    //--------------------------------------------------------------------------------------------------news
    // ?action=getNews&dateinsert=2023-01-20.
    if (e.parameter.action=='getNews') return getNews(e.parameter.dateinsert);
    // ?action=getNews1&sheetName=starred2022&value=2022-10-31.
    if (e.parameter.action=='getNews1') return getNews1(e.parameter.sheetName,e.parameter.value,e.parameter.fileId);

    //--------------------------------------------------------------------------------------------------tags
    if (e.parameter.action=='getTagQuote') return getTagQuote(e.parameter.sourceSheetName,e.parameter.ID,e.parameter.fileId);
    //--------------------------------------------------------------------------------------------------select
    if (e.parameter.action=='selectWhere') return selectWhere(e);
  }catch(e) {
    return ContentService.createTextOutput( 'Error: runtime error \n\n' + querystring + '\n\n'  +  JSON.stringify(e));
  }
  return ContentService.createTextOutput(  'Error: wrong parametrs \n\n' + querystring );

  
}
//=QUERY(starred2022!A1:H333, "select * where B like '@Dala%' ",1)

