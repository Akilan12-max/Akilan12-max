import 'dart:io';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'dart:async';

import 'api_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = "https://60585b2ec3f49200173adcec.mockapi.io/api/v1/";

  Future<dynamic> get({String url, String token}) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url,
          headers: {HttpHeaders.authorizationHeader: token});
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post({String url, dynamic body}) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response = await http.post(
        _baseUrl + url,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = response.body;
      print(responseJson);
      return responseJson;
    case 201:
      var responseJson = response.body;
      print("responseJson--- $responseJson");
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
