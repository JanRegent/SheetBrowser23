import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../2business_layer/models/sheetdb/_sheetdb.dart';
import 'getsheetdl.dart';

//https://medium.com/@sinnoorc/networking-in-flutter-dio-getx-state-mixin-flutter-3-3-5-b012130f677e

class GappsAdapter {
  String gappsExecUrl = '';
  bool isReady = false;
  Future init() async {}

  Future getRowsAllDynamic(String fileId, String sheetName) async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

    dio.options.connectTimeout = 3000;
    try {
      dio.options.baseUrl = gappsExecUrl;
      dio.options.headers.addAll({
        'content-type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
      });
      String queryString =
          '?action=getRowsAll&sheetName=$sheetName&fileId=$fileId';
      //var response = await dio.get(gappsExecUrl + queryString);
      var response = await Dio().get(gappsExecUrl + queryString);

      return response.data;
    } catch (e, s) {
      logDb.createErr('sheetDB.create', e.toString(), s.toString(),
          descr: '$fileId\nsheetName: $sheetName');
    }
    return {};
  }

  Future getRowsRest(String fileId, String sheetName) async {
    int lastRowNo = 0;
    //await sheetRowsDb.readIdLast(fileId, sheetName);

    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

    dio.options.connectTimeout = 3000;
    try {
      dio.options.baseUrl = gappsExecUrl;
      dio.options.headers.addAll({
        'content-type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
      });
      String queryString =
          '?action=getsheetRest&sheetName=$sheetName&lastRowNo=$lastRowNo&fileId=$fileId';
      //print(gappsExecUrl + queryString);
      var response = await Dio().get(gappsExecUrl + queryString);
      return response.data;
    } catch (e, s) {
      logDb.createErr('gappsAdapter.getRowsRest', e.toString(), s.toString(),
          descr: '$fileId\nsheetName: $sheetName');
    }

    return {};
  }
}

Future postAppendStarred(List<String> rowArr) async {
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  ));
  //   dio.head('Access-Control-Allow-Origin', "*");
  // add_header Access-Control-Allow-Methods "GET, HEAD";
  dio.options.connectTimeout = 3000;
  try {
    dio.options.baseUrl = appendServiceUrl;
    dio.options.headers.addAll({
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
    });
    var formData = {
      'rowArr': rowArr,
    };
    var response = await dio.post('', data: formData);
    return response.data;
  } catch (e, s) {
    logDb.createErr('postAppendStarred', e.toString(), s.toString(),
        descr: '$rowArr');
  }
  return {};
}

Future getAppendStarredDIO(List<String> rowArr) async {
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  ));

  dio.options.connectTimeout = 3000;
  try {
    dio.options.baseUrl = appendServiceUrl;
    dio.options.headers.addAll({
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
    });
    String queryString = '?rowArr=$rowArr';
    //var response = await dio.get(gappsExecUrl + queryString);
    var response = await Dio().get(appendServiceUrl + queryString);
    return response.data;
  } catch (e, s) {
    logDb.createErr(
      'sheetDB.create',
      e.toString(),
      s.toString(),
    );
  }
  return {};
}
