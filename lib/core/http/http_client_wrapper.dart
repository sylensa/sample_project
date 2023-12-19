
import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'generic_http_response.dart';

enum HttpRequestType {
  GET,
  POST,
  PUT,
  DELETE,
  DOWNLOAD,
}

class HttpClientWrapper {
  static var dio = Dio(); //Client
  final Box _box = Hive.box('app');

  static const String _baseUrl = 'https://api.spacexdata.com/v3';
  static const kLoginUrls = ['spacexdata', 'login'];

  static String apiUrl(String path, Map<String, dynamic>? queryParams) {
    var uriString = '$_baseUrl/$path';
  print("uriString:$uriString");
    return Uri.parse(uriString)
        .replace(queryParameters: queryParams)
        .toString();
  }

  static HttpClientWrapper? _instance;

  HttpClientWrapper._internal() {
    //NOTE: The logic below will only be executed if no instance exist
    //So initialization logic can be added here
    _init();
    _instance = this;
  }

  factory HttpClientWrapper() => _instance ?? HttpClientWrapper._internal();

  _init() {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) {

        // check if url is in the server api and url
        // is not protected by logged in user
          Box box = Hive.box("app");

            if (_baseUrl.contains(options.uri.host) &&
            !kLoginUrls.contains(options.uri.path.split('/').last)) {
          final token = box.get('token');

          options.headers = {
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          };
        }

        return handler.next(options);
      }, onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        return handler.next(response);
      }, onError: (DioError e, ErrorInterceptorHandler handler) async {
        print(e.error.toString());

        if (e.response?.statusCode == 401 ) {
          // return appLogout();
        }
        return handler.next(e);
      }),
    );

    // dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: _baseUrl)).interceptor);
  }



  Future<GenericHttpResponse> _executeHttpRequest(
    HttpRequestType httpRequestType,
    String path,
    Map<String, dynamic>? queryParams, {
    dynamic body,
  }) async {
    Response dioResponse;
    GenericHttpResponse response = GenericHttpResponse();

    // final cacheDuration = 1;

    try {
      switch (httpRequestType) {
        case HttpRequestType.GET:
          dioResponse = await dio.get(
            apiUrl(path, queryParams),
            // options: buildCacheOptions(Duration(days: cacheDuration)),
          );
          break;
        case HttpRequestType.POST:
          print("path:$path");
          print("queryParams:$queryParams");
          print("body:$body");
          dioResponse = await dio.post(
            apiUrl(path, queryParams),
            data: body,
            // options: buildCacheOptions(Duration(days: cacheDuration)),
          );
          break;
        case HttpRequestType.PUT:
          dioResponse = await dio.put(
            apiUrl(path, queryParams),
            data: body,
            // options: buildCacheOptions(Duration(days: cacheDuration)),
          );
          break;
        case HttpRequestType.DELETE:
          dioResponse = await dio.delete(apiUrl(path, queryParams));
          break;
        case HttpRequestType.DOWNLOAD:
          dioResponse = await dio.get<ResponseBody>(apiUrl(path, queryParams),
              options: Options(responseType: ResponseType.stream));
          break;
        default:
          dioResponse = await dio.get(
            apiUrl(path, queryParams),
            // options: buildCacheOptions(Duration(days: cacheDuration)),
          );
          break;
      }
      //Request was a success
      response.success = true;
      response.body = dioResponse.data;
      response.status = dioResponse.statusCode;
      print("response.body:${response.body}");

      return response;
    } catch (e) {
      final dioError = e as DioError;
      // Get.snackbar("Dio Error", dioError.response?.data?.toString() ?? '');
      if (dioError.response?.data is Map) {
        // collect possible error keys
        var responseMap = dioError.response?.data as Map;

        response.body = dioError.response?.data['data'];

        if (response.body != null) {
          response.body = response.body['message'];
        }

        response.body ??= dioError.response?.data['error'];
        response.body ??= dioError.response?.data['errors'];
        response.body ??= dioError.response?.data['message'];

        if (response.body is List && response.body.isNotEmpty) {
          var _value = "";
          try {
            for (var x in response.body) {
              // if map value concatenation fails
              try {
                _value += "• ${(x?['msg'] ?? x?['message'] ?? "")}\n";
              } catch (error) {
                _value += "• ${x}\n";
              }
            }
            // trim extra new line
            _value = _value.trim();

            response.body = _value;
          } catch (e) {
            response.body = response.body.join("\n");
          }
        }

        response.body ??= (dioError.response?.data as Map).values.join("\n");
      } else if (dioError.response?.data is String) {
        response.body = dioError.response?.data;
      } else {
        response.body = dioError.message;
      }

      // pass the message also to the
      // body
      print("response.body:${response.body}");
      response.message = response.body;

      response.status = dioError.response?.statusCode;
      response.error = dioError.error;
      print("response.error :${response.error }");

      throw (response);
    }
  }

  Future<GenericHttpResponse> getRequest(String path,
      {Map<String, dynamic>? queryParams}) async {
    return await _executeHttpRequest(HttpRequestType.GET, path, queryParams);
  }

  Future<GenericHttpResponse> postRequest(String path,
      {Map<String, dynamic>? queryParams, dynamic body}) async {
    return await _executeHttpRequest(HttpRequestType.POST, path, queryParams,
        body: body);
  }

  Future<GenericHttpResponse> putRequest(String path,
      {Map<String, dynamic>? queryParams, dynamic body}) async {
    return await _executeHttpRequest(HttpRequestType.PUT, path, queryParams,
        body: body);
  }

  Future<GenericHttpResponse> deleteRequest(String path,
      {Map<String, dynamic>? queryParams}) async {
    return await _executeHttpRequest(HttpRequestType.DELETE, path, queryParams);
  }

  Future<Response> downloadRequest(String path,
      {Map<String, dynamic>? queryParams}) async {
    return dio.get<Uint8List>(apiUrl(path, queryParams),
        options: Options(responseType: ResponseType.bytes));
  }

  static Future<Map?> getCountryDetails() async {
    try {
      debugPrint("ip api data: ");
      var details = await dio.get("http://ip-api.com/json");
      debugPrint("ip api data: ${details.data}");
      return details.data;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
