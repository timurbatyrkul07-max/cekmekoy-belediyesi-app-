import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_config.dart';
import 'api_exception.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      validateStatus: (s) => s != null && s < 500,
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: false,
        responseBody: false,
        request: true,
        responseHeader: false,
        error: true,
      ));
    }
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: query);
      return _unwrap(res);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final res = await _dio.post(path, data: body);
      return _unwrap(res);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Map<String, dynamic> _unwrap(Response res) {
    if (res.statusCode == null || res.statusCode! >= 400) {
      throw ApiException(
        statusCode: res.statusCode,
        message: _extractErrorMessage(res.data),
      );
    }
    if (res.data is Map<String, dynamic>) {
      return res.data as Map<String, dynamic>;
    }
    throw ApiException(message: 'Beklenmeyen yanıt formatı');
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map) {
      // ASP.NET validation problem details
      if (data['errors'] is Map) {
        final errs = (data['errors'] as Map).values.expand((v) {
          if (v is List) return v.map((e) => e.toString());
          return [v.toString()];
        }).toList();
        if (errs.isNotEmpty) return errs.join('\n');
      }
      if (data['message'] is String && (data['message'] as String).isNotEmpty) {
        return data['message'] as String;
      }
      if (data['title'] is String) return data['title'] as String;
    }
    return 'Beklenmeyen hata oluştu';
  }

  ApiException _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return NetworkException();
    }
    final status = e.response?.statusCode;
    if (status == 401 || status == 403) return UnauthorizedException();
    if (status == 404) return NotFoundException();
    return ServerException(
      statusCode: status,
      message: _extractErrorMessage(e.response?.data),
    );
  }
}

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
