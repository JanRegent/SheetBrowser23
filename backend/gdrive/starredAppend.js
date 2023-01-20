


function decodeQueryParam(p) {
  return decodeURIComponent(p.replace(/\+/g, " "));
}
function isbadJSONing(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}


var todecode = 'citat,autor,tags,kniha,strana,vydal,sourceSheetName,sourceSheetID,dateinsert,folder,sourceUrl,ID__%7C__%7Bcitat:%20Za%C4%8Dn%C4%9Bte%20n%C3%A9st%20ovoce%20odpov%C3%ADdaj%C3%ADc%C3%AD%20va%C5%A1emu%20pok%C3%A1n%C3%AD.%20(Matou%C5%A1%203:8),%20autor:%20,%20tags:%20,%20kniha:%20Matou%C5%A1%203:8,%20strana:%20,%20vydal:%20,%20sourceSheetName:%20bible21,%20sourceSheetID:%201331,%20dateinsert:%202023-01-20.,%20folder:%20,%20sourceUrl:%20,%20ID:%203%7D';

function starredAppend(encodedRow) {
  Tamotsu.initialize();
  var sourceAgent =    Tamotsu.Table.define({ sheetName: 'starred2022', idColumn: 'ID' });
  var row = string2json(encodedRow);

  createRow(sourceAgent, row);

   return ContentService.createTextOutput(JSON.stringify({action: "starredAppend", result: "OK-starred"}));

}

function string2json(encodedString) {
  var decoded =  decodeURI(encodedString);

 
  var arr = decoded.split('__|__');
  var cols = arr[0].split(',');
  var badJSON = arr[1];


  for (var colIx = 0; colIx < cols.length; colIx = colIx + 1) {
    var colQ = '"' +cols[colIx]+ '"';
    badJSON = badJSON.replaceAll(cols[colIx], colQ);
    badJSON = badJSON.replaceAll(', ' + colQ + ': ', '", ' + colQ + ': "');
  }
  var colQ = '"' +cols[0]+ '": ';
  badJSON = badJSON.replaceAll(colQ, colQ + '"');
  badJSON = badJSON.substring(0,badJSON.length-1) + '"}'
  badJSON = badJSON.replace('"sourceSheet"ID""', '"sourceSheetID"')

  
  var obj = eval( '(' + badJSON + ')' );
  //Logger.log(isbadJSONing(badJSON));
  return obj
}

function starredAppend__test() {
  starredAppend(todecode)
  
}




