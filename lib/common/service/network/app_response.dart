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

    return switch (response.statusCode) {
      (200 || 201) => jsonDecode(response.body),
      (400) => throw BadRequestException(
          utf8.decode(response.bodyBytes), response.request!.url.toString()),
      (403) => throw UnauthorizedRequestException(
          utf8.decode(response.bodyBytes), response.request!.url.toString()),
      (404) => throw FetchDataException("Data not Found.", ""),
      (419) => throw FetchDataException(
          "${jsonDecode(response.body)['message']}",
          response.request!.url.toString()),
      (422) => throw FetchDataException(
          response.body, response.request!.url.toString()),
      (429) => throw BadRequestException(
          "Too Many Request! Please try one at a time.",
          response.request!.url.toString()),
      (500) => throw FetchDataException(
          "Internal Server Error.", response.request!.url.toString()),
      (609) => "Data not Found.",
      (_) => throw FetchDataException(
          'Error occurred with code : ${response.statusCode}, ${response.body}',
          response.request!.url.toString())
    };
  }
}
