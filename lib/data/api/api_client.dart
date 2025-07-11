import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio() {
    final apiKey = dotenv.env['API_KEY'];
    final baseUrl = dotenv.env['BASE_URL'];

    if (apiKey == null || baseUrl == null) {
      throw Exception(
        'API_KEY or BASE_URL is not set in the .env file. Please ensure it is created and configured.',
      );
    }

    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $apiKey';
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParams,
        Options? options,
      }) async {
    return _dio.get(
      path,
      queryParameters: queryParams,
      options: options,
    );
  }

  Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
      }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParams,
      options: options,
    );
  }

  Future<Response> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
      }) async {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParams,
      options: options,
    );
  }

  Future<Response> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
      }) async {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParams,
      options: options,
    );
  }

  Future<Response> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
      }) async {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParams,
      options: options,
    );
  }
}