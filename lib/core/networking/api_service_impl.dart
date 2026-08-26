import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stream_pro/core/error/exceptions/server_exception.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/networking/interceptors/auth_interceptor.dart';
import 'package:stream_pro/core/networking/interceptors/cookie_logger_interceptor.dart';
import 'package:stream_pro/core/storage/token_storage_service.dart';
import 'api_constants.dart';

class ApiServiceImpl implements ApiService {
  final Dio _dio;
  late final PersistCookieJar _cookieJar;
  final TokenStorageService _tokenStorage;

  ApiServiceImpl(this._dio, this._tokenStorage) {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60 * 5),
    );
  }

  @override
  Future<void> initialize() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies/';

    _cookieJar = PersistCookieJar(
      storage: FileStorage(cookiePath),
      ignoreExpires: false, // Respect cookie expiration dates
    );

    // Add cookie manager to handle cookies automatically
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors.add(AuthInterceptor(_tokenStorage));

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90, // keeps lines readable in consoles
        ),
      );
      _dio.interceptors.add(CookieLoggerInterceptor(_cookieJar));
    }
  }

  // Clear all cookies (useful for logout)
  @override
  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
    if (kDebugMode) {
      print('🍪 ALL COOKIES CLEARED FROM STORAGE');
    }
  }

  @override
  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<Response> patch(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.patch(path, data: data, options: options);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
