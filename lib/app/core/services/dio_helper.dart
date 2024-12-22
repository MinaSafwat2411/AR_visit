import 'package:dio/dio.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.4.36:8000',
      receiveDataWhenStatusError: true,
    ),
  );

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query, // Make query required
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
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
      'lang': lang,
      'Authorization': token ?? '',
      'Accept': 'application/json',
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> logout({
    required String url,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': "Bearer $token" ?? '',
      'Accept': 'application/json',
    };

    return await dio.post(
      url,
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
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}