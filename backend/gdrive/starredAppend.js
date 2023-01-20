


function decodeQueryParam(p) {
  return decodeURIComponent(p.replace(/\+/g, " "));
}
function isJSONing(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}


var todecode = 'sheetName%7CdailyNotes__%7C__ID%7C384__%7C__fileId%7C1oklmBpFWHAUCU4nPpNUMOQAZ0jIA1U_zfVtIWxHhBG0';

function starredAppend(rowValue) {
  Tamotsu.initialize();
  var sourceAgent =    Tamotsu.Table.define({ sheetName: 'starred2022', idColumn: 'ID' });
  var row = decodeURI(rowValue);
  Logger.log(isJSONing(row))
  Logger.log(row); //['"citat"']
Logger.log(row.keys); 
Logger.log(row['citat']); //
  //createRow(sourceAgent, rowValue);

  return ContentService.createTextOutput(JSON.stringify({action: "starredAppend", result: "OK-starred"}));

}

function starredAppend__test() {
  starredAppend(todecode)
  
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





