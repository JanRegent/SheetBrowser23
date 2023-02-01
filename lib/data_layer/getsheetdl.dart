import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:sheetbrowser/2business_layer/appdata/approotdata.dart';

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
      debugPrint(e.toString());

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
      debugPrint(e.toString());

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
    return message;
  }
}
