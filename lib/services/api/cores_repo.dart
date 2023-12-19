// Dart imports:
// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Project imports:
import 'package:sample_project/core/helpers/constants.dart';

import '../../../core/http/generic_http_response.dart';
import '../../../core/http/http_client_wrapper.dart';

class CoresRepo {
  final HttpClientWrapper _http = HttpClientWrapper();

  Future<GenericHttpResponse> getAllCores() async {
    final response =  _http.getRequest(
      cores,
    );

    return response;
  }


}
