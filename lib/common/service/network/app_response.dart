import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'exceptions/app_exception.dart';

class AppResponse {
  AppResponse(Response response);
  static dynamic processResponse(Response response) {
    if (kDebugMode) {
      log("response body => : ${response.body}");
    }

    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnauthorizedRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());

      case 404:
        throw FetchDataException(
          "Data not Found.",
          "",
        );
      case 419:
        throw FetchDataException("${jsonDecode(response.body)['message']}",
            response.request!.url.toString());

      case 422:
        throw FetchDataException(
            response.body, response.request!.url.toString());

      case 429:
        throw BadRequestException("Too Many Request! Please try one at a time.",
            response.request!.url.toString());

      case 500:
        throw FetchDataException(
            "Internal Server Error.", response.request!.url.toString());
      case 609:
        return "Data not Found.";
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}, ${response.body}',
            response.request!.url.toString());
    }
  }
}
