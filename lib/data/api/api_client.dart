import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:worker_manager/worker_manager.dart';

import '../../domain/models/category.dart';
import '../../domain/models/transaction_response.dart';
import 'iapi_client.dart';

class ApiClient implements IApiClient{
  final Dio _dio;

  ApiClient() : _dio = Dio() {
    final apiKey = dotenv.env['API_KEY'];
    final baseUrl = dotenv.env['BASE_URL'];

    if (apiKey == null || baseUrl == null) {
      throw Exception('API_KEY or BASE_URL is not set in the .env file');
    }

    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $apiKey';
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (_needsDeserialization(response)) {
            try {
              response.data = await _deserializeInIsolate(response.data);
            } catch (e) {
              return handler.reject(DioException(
                requestOptions: response.requestOptions,
                error: 'Deserialization error: $e',
              ));
            }
          }
          handler.next(response);
        },
      ),
    );
  }

  bool _needsDeserialization(Response response) {
    return response.data is Map || response.data is List;
  }

  Future<dynamic> _deserializeInIsolate(dynamic data) async {
    return await workerManager.execute(
          () => _parseJsonInIsolate(data),
    );
  }

  static dynamic _parseJsonInIsolate(dynamic data) {
    if (data is List) {
      return data.map(_convertItem).toList();
    }
    return _convertItem(data);
  }

  static dynamic _convertItem(dynamic json) {
    if (json['type'] == 'transaction') {
      return TransactionResponse.fromJson(json);
    } else if (json['type'] == 'category') {
      return Category.fromJson(json);
    } else if (json['type'] == 'bank_account') {
      return Category.fromJson(json);
    }
    return json;
  }

  @override
  Future<T> get<T>(String path, {
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParams,
      options: options,
    );
    return response.data as T;
  }

  @override
  Future<T> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    final response = await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data as T;
  }

  @override
  Future<T> put<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    final response = await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data as T;
  }

  @override
  Future<T> delete<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    final response = await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  Future<void> dispose() async {
    await workerManager.dispose();
  }
}