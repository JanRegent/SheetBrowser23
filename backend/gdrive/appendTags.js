
function appendTagsDo(e) {
      logi(e.parameter.action)
      var sheetName = e.parameter.sheetName
      var sheetID = e.parameter.sheetID
      var tags = e.parameter.tags

      return appendTags2(sheetName, sheetID, tags);
}


function appendTags2(sheetName, sheetID, tags) {
  appRootDataValuesLoad() 

  try {
    logi(sheetName + ' ' + sheetID)

    var agent = getAgent('', 'hledaniList')
    var row = agent.where({ sheetName: sheetName }).first();
    
    agent = getAgent(row['fileUrl'], sheetName);
    var ID = parseInt(sheetID);
    row = agent.where({ ID: ID }).first();
    if (row == undefined) 
      return ContentService.createTextOutput(JSON.stringify({action: "appendTags", result: "Err-row by ID not found"}));

    logi('tags before:' + row['tags'])
    row['tags'] = row['tags'] +','+ tags;
    if (row['tags'].substring(0,1) == ',') row['tags'] = row['tags'].substring(1);
    logi('tags after:' + row['tags'])
    row.save()

    
  }catch(e){
    logi('appendTags2Do(): '  + e.toString())
  }
  return ContentService.createTextOutput(JSON.stringify({action: "appendTags", result: "OK-appendTags"}));

}

function insertTagsColumn(sheet ) {
  var header = sheet.getDataRange().getValues()[0]
  if (header.indexOf('tags') > -1) return;
  sheet.insertColumnAfter(6).getRange(1, header.length).setValue("tags");
}

// ?action=relAppend&sheetName=PapajiDailyPedia&sheetID=21&selName=*

function appendTagsDo__test() {
  logclear();
  appendTags2('PapajiDailyPedia', '6', 'aa,bb')
  
}

function loopStars() {
  var starAgent = getAgentActive('*');
  logclear();

  var rows = starAgent.all();

   for (var rowIx = 1; rowIx < rows.length; rowIx = rowIx + 1) {
    var row = rows[rowIx];
    Logger.log(row['sheetName'] +' '+row['sheetID'] )
    appendTags2(row['sheetName'] , row['sheetID'], '*')
  }


  
}

