import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'app_response.dart';
import 'exceptions/app_exception.dart';

const String _baseUrl = "khalti.com";
const String _apiVersion = "api/v5/";

const int _timeoutDuration = 10000;

class BaseClient {
  ///Get Request
  Future<dynamic> getResponse({
    required http.Client baseHttp,
    String? endPoint,
    Map<String, dynamic>? queryParameters,
    String? deviceModel,
  }) async {
    Uri uri = Uri(
      scheme: "https",
      host: _baseUrl,
      path: "$_apiVersion${endPoint ?? "bank"}",
      queryParameters: queryParameters,
    );

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'DEVICE_MODEL': 'FLTASSIGN_Ashwin_Shrestha_${deviceModel ?? ''}',
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
      'true', // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };

    if (kDebugMode) {
      log("get request => ${uri.toString()}");
    }
    try {
      var response = await baseHttp
          .get(uri, headers: header)
          .timeout(const Duration(seconds: _timeoutDuration));
      return AppResponse.processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection", uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          "API not responded in time", uri.toString());
    }
  }
}
