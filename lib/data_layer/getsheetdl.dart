import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'package:sheetbrowse/2business_layer/approotdata.dart';

var sessionManager = SessionManager();

void sessionLog(String key, String value) {
  sessionManager.set('__log__$key', value);
}

class GoogleSheetsDL {
  final String? sheetName;
  String sheetId = '';
  // obtain your api key on https://console.developers.google.com/
  GoogleSheetsDL({
    required this.sheetName,
    required this.sheetId,
  });

  Future<List> getAllSheet() async {
    String? apiKey = AppDataPrefs.getApikey();
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$sheetName?key=$apiKey';

    sessionLog('url-getAllSheet', url);
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData['values'];
    } on SocketException {
      throw Failure(message: "Error: No Internet Connection. [getAllSheet]");
    } on HttpException {
      throw Failure(message: "Error: Internal Issue Occured. [getAllSheet]");
    } on FormatException {
      throw Failure(message: "Error: Bad Response. [getAllSheet]");
    } catch (e) {
      debugPrint(e.toString());

      return [];
      // you can show any error widgets for your users here.
    }
  }

  Future getNewsBuild(String dateinsert) async {
    String? selectServiceUrl = AppDataPrefs.getString('selectServiceUrl', '');

    if (!dateinsert.endsWith('.')) dateinsert = '$dateinsert.';
    String url = '$selectServiceUrl?action=getNews&dateinsert=$dateinsert';
    sessionLog('url-getNews', url);
    await http.get(Uri.parse(url));
    return 'OK';
  }

  Future starredAppend(String encoded) async {
    String? selectServiceUrl = AppDataPrefs.getString('selectServiceUrl', '');

    String url = '$selectServiceUrl?action=starredAppend&value=$encoded';
    sessionLog('url-starredAppend', url);
    print(url);
    await http.get(Uri.parse(url));
    return 'OK';
  }

  Future selectData() async {
    String url =
        'https://script.google.com/macros/s/AKfycbzfN5YsBSbhwfk9FbbCmIFjz6wkBkHFXVCk6zMytHdjdUO6DjSL_OSKcgrVEWj81EpIww/exec?sheetName=starred2022&colLetter=B&value=@Dala';
    sessionLog('url-selectData', url);
    try {
      final response = await http.get(Uri.parse(url));
      return jsonDecode(response.body);
    } on SocketException {
      throw Failure(message: "Error: No Internet Connection. [selectData]");
    } on HttpException {
      throw Failure(message: "Error: Internal Issue Occured. [selectData]");
    } on FormatException {
      throw Failure(message: "Error: Bad Response. [selectData]");
    } catch (e) {
      debugPrint(e.toString());

      return [];
      // you can show any error widgets for your users here.
    }
  }
} //class

Future getTagQuote(String sourceSheetName, String id, String fileId) async {
  String? url = AppDataPrefs.getString('selectServiceUrl', '');
  url =
      '$url?action=getTagQuote&sourceSheetName=$sourceSheetName&ID=$id&fileId=$fileId';
  sessionLog('url-getTagQuote', url);
  try {
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  } on SocketException {
    throw Failure(message: "Error: No Internet Connection. [getTagQuote]");
  } on HttpException {
    throw Failure(message: "Error: Internal Issue Occured. [getTagQuote]");
  } on FormatException {
    throw Failure(message: "Error: Bad Response. [getTagQuote]");
  } catch (e) {
    debugPrint(e.toString());

    return [];
    // you can show any error widgets for your users here.
  }
}

class Failure {
  final String message;
  Failure({required this.message});

  @override
  String toString() {
    sessionLog(message, 'Failure');
    return message;
  }
}
