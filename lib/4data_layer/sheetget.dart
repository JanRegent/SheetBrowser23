import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class GoogleSheets {
  final String apiKey, sheetId, sheetName;
  // obtain your api key on https://console.developers.google.com/
  GoogleSheets({
    this.apiKey = 'AIzaSyCbzsTyeqolOiYWJo2ODjuSCbFjI46OUfU',
    required this.sheetName,
    required this.sheetId,
  });
  Future<List> sheetValues() async {
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$sheetName?key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData['values'];
    } catch (e) {
      debugPrint(e.toString());

      return [];
      // you can show any error widgets for your users here.
    }
  }

  Future selectData() async {
    String url =
        'https://script.google.com/macros/s/AKfycbzfN5YsBSbhwfk9FbbCmIFjz6wkBkHFXVCk6zMytHdjdUO6DjSL_OSKcgrVEWj81EpIww/exec?sheetName=starred2022&colLetter=B&value=@Dala';

    try {
      final response = await http.get(Uri.parse(url));
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());

      return [];
      // you can show any error widgets for your users here.
    }
  }
}//class

