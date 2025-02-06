import 'dart:io';
import 'package:dio/dio.dart';
import '../utils/backend_endpoint.dart';

/// Custom Exception for No Internet
class NoInternetException implements Exception {
  final String message;
  NoInternetException(this.message);

  @override
  String toString() => message;
}

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: BackendEndpoint.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10), // Timeout for connection
      receiveTimeout: const Duration(seconds: 10), // Timeout for response
    ),
  );

  /// **Handles Dio exceptions**
  static Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NoInternetException("Connection timeout. Please check your internet.");
    } else if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      return NoInternetException("No internet connection. Please check your network.");
    } else if (e.response != null) {
      return Exception("API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}");
    }
    return Exception("Unexpected error: ${e.message}");
  }

  /// **GET Request**
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Accept-Language': lang,
        'Authorization': token != null ? "Bearer $token" : '',
        'Content-Type': 'application/json',
      };

      return await dio.get(url, queryParameters: query);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// **POST Request**
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Accept-Language': lang,
        'Authorization': token != null ? "Bearer $token" : '',
        'Content-Type': 'application/json',
      };

      return await dio.post(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// **PUT Request**
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Accept-Language': lang,
        'Authorization': token != null ? "Bearer $token" : '',
        'Content-Type': 'application/json',
      };

      return await dio.put(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}
