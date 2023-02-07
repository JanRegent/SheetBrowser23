import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:sheetbrowser/2business_layer/appdata/approotdata.dart';

import '../2business_layer/models/sheetdb/_sheetdb.dart';

///CORS
///https://pub.dev/packages/flutter_cors
///
///dart pub global activate flutter_cors
///
///C:\Users\janre\AppData\Local\Pub\Cache\bin\fluttercors --disable
///
//Patching C:\Android\flutter/packages/flutter_tools/lib/src/web/chrome.dart
//Deleting C:\Android\flutter/bin/cache/flutter_tools.stamp
//CORS checks are now disabled for Flutter's Chrome instance
///
///
///

class GoogleSheetsDL {
  final String? sheetName;
  String sheetId = '';
  // obtain your api key on https://console.developers.google.com/
  GoogleSheetsDL({
    required this.sheetName,
    required this.sheetId,
  });

  Future<List> getSheet() async {
    String? apiKey = AppDataPrefs.getApikey();
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$sheetName?key=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        String errMess = 'Error:[DL] Could not connect to server';
        AppDataPrefs.setString('errorLastDL', errMess);
        throw Exception(errMess);
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData['values'];
    } on SocketException {
      throw Failure(message: "Error: No Internet Connection. [getAllSheet]");
    } on HttpException {
      throw Failure(message: "Error: Internal Issue Occured. [getAllSheet]");
    } on FormatException {
      throw Failure(message: "Error: Bad Response. [getAllSheet]");
    } catch (e) {
      return [];
      // you can show any error widgets for your users here.
    }
  }

  Future getNewsBuild(String dateinsert) async {
    String? selectServiceUrl = AppDataPrefs.getString('selectServiceUrl');

    if (!dateinsert.endsWith('.')) dateinsert = '$dateinsert.';
    String url = '$selectServiceUrl?action=getNews&dateinsert=$dateinsert';
    await http.get(Uri.parse(url));

    return 'OK';
  }

  Future starredAppend(String starredLink) async {
    String? selectServiceUrl = AppDataPrefs.getString('selectServiceUrl');
    String starredLinkEncoded = Uri.encodeFull(starredLink);
    String url =
        '$selectServiceUrl?action=starredAppend&starredLink=$starredLinkEncoded';

    await http.get(Uri.parse(url));
    return 'OK';
  }

  Future selectData() async {
    String url =
        'https://script.google.com/macros/s/AKfycbzfN5YsBSbhwfk9FbbCmIFjz6wkBkHFXVCk6zMytHdjdUO6DjSL_OSKcgrVEWj81EpIww/exec?sheetName=starred2022&colLetter=B&value=@Dala';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Error:[DL] Could not connect to server');
      }
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure(message: "Error: No Internet Connection. [selectData]");
    } on HttpException {
      throw Failure(message: "Error: Internal Issue Occured. [selectData]");
    } on FormatException {
      throw Failure(message: "Error: Bad Response. [selectData]");
    } catch (e) {
      return [];
      // you can show any error widgets for your users here.
    }
  }
} //class

Future getTagQuote(String sourceSheetName, String id, String fileId) async {
  String? url = AppDataPrefs.getString('selectServiceUrl');
  url =
      '$url?action=getTagQuote&sourceSheetName=$sourceSheetName&ID=$id&fileId=$fileId';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Error:[DL] Could not connect to server');
    }
    return jsonDecode(response.body);
  } on SocketException {
    throw Failure(message: "Error: No Internet Connection. [getTagQuote]");
  } on HttpException {
    throw Failure(message: "Error: Internal Issue Occured. [getTagQuote]");
  } on FormatException {
    throw Failure(message: "Error: Bad Response. [getTagQuote]");
  } catch (e) {
    return [];
    // you can show any error widgets for your users here.
  }
}

String appendServiceUrl =
    'https://script.google.com/macros/s/AKfycbzV7T-PJ0_dKed6rDU0M9kqBHhNwkNDbUp6vaJuRYNWJrKMFwVzAQCZqPoWrW8zwhta/exec';

Future getAppendStarred(List<String> rowArr) async {
  String? url = appendServiceUrl;
  rowArr[0] = rowArr[0] + DateTime.now().toIso8601String();
  String rowStr = rowArr.join('__|__');
  url = '$url?rowArr=$rowStr';
  var encoded = Uri.encodeFull(url);
  print(url);

  try {
    final response = await http.get(
      Uri.parse(encoded),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.accessControlAllowOriginHeader: "*",
        HttpHeaders.accessControlAllowMethodsHeader:
            "GET,PUT,PATCH,POST,DELETE",
        HttpHeaders.accessControlAllowHeadersHeader:
            "Origin, X-Requested-With, Content-Type, Accept",
        HttpHeaders.accessControlAllowCredentialsHeader: 'false'
      },
    );

    //Response response = await http.get(Uri.parse(encoded));
    print(response.statusCode);
    //   if (response.statusCode != 200) {
    //     throw Exception(
    //         'Error:[DL].getAppendStarred Could not connect to server');
    //   }
    //   return jsonDecode(response.body);
    // } on SocketException {
    //   throw Failure(
    //       message:
    //           "Error: [DL].getAppendStarred No Internet Connection. [getTagQuote]");
    // } on HttpException {
    //   throw Failure(
    //       message:
    //           "Error: [DL].getAppendStarred Internal Issue Occured. [getTagQuote]");
    // } on FormatException {
    //   throw Failure(
    //       message: "Error: [DL].getAppendStarred Bad Response. [getTagQuote]");
  } catch (e, s) {
    logDb.createErr('[DL].getAppendStarred', e.toString(), s.toString(),
        descr: 'statusCode: ');
  }
  return [];
  // you can show any error widgets for your users here.
}

class Failure {
  final String message;
  Failure({required this.message});
  @override
  String toString() {
    return message;
  }
}
