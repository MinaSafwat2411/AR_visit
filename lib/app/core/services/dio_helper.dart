import 'package:dio/dio.dart';

import '../utils/backend_endpoint.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: BackendEndpoint.baseUrl,
      receiveDataWhenStatusError: true,
    ),
  );

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Accept-Language': lang,
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data, // Make data required
    Map<String, dynamic>? query, // Make query required
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Accept-Language': lang,
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data, // Make data required
    Map<String, dynamic>? query, // Make query required
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Accept-Language': lang,
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}