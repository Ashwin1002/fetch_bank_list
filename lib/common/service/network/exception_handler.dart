import 'dart:io';

import 'package:flutter/foundation.dart';

import 'exceptions/app_exception.dart';

class ExceptionHandler {
  String parseError(error) {
    String errorTxt = "";
    if (error is BadRequestException) {
      errorTxt = error.message;
    }

    /// no internet
    else if (error is SocketException) {
      errorTxt = "No Internet Connection";
    }

    /// user time out
    else if (error is ApiNotRespondingException) {
      errorTxt = "Connection Time Out";
    }

    /// api error
    else if (error is FetchDataException) {
      errorTxt = error.message;
    }

    /// other errors
    else {
      errorTxt = kDebugMode
          ? error.toString()
          : "Some Error Occurred while processing response";
    }
    return errorTxt;
  }
}
