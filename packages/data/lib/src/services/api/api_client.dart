import 'package:dio/dio.dart';

import '../../core/errors/data_exception.dart';

/// API クライアント。PokeAPI への HTTP リクエストをラップする。
class ApiClient {
  ApiClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://pokeapi.co/api/v2',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  final Dio _dio;

  /// GET リクエストを実行する。
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw DataException('Failed to GET $path', original: e);
    }
  }
}
