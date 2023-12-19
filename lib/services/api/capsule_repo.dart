// Dart imports:
// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Project imports:
import 'package:sample_project/core/helpers/constants.dart';

import '../../../core/http/generic_http_response.dart';
import '../../../core/http/http_client_wrapper.dart';

class CapsuleRepo {
  final HttpClientWrapper _http = HttpClientWrapper();


  Future<GenericHttpResponse> getAllCapsules() async {
    final response =  _http.getRequest(
      capsules,
    );

    return response;
  }

}
