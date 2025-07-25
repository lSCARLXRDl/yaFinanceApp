import 'package:dio/dio.dart';

abstract class IApiClient {
  Future<T> get<T>(
      String path, {
        Map<String, dynamic>? queryParams,
        Options? options,
      });

  /// POST-запрос
  Future<T> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      });

  /// PUT-запрос
  Future<T> put<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      });

  /// DELETE-запрос
  Future<T> delete<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParams,
        Options? options,
        CancelToken? cancelToken,
      });
}