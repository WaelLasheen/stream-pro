import 'package:dio/dio.dart';
import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/services/storage/token_storage_service.dart';
import 'package:stream_pro/core/utils/extensions/number_range.dart';

class RefreshInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorageService tokenStorage;

  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];

  RefreshInterceptor({required this.dio, required this.tokenStorage});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 1. Ignore non-401 errors or requests to auth endpoints (prevents loops)
    if (err.response?.statusCode != 401 ||
        _isRefreshRequest(err.requestOptions)) {
      return handler.next(err);
    }

    // 2. If already refreshing, queue this request to be retried later
    if (_isRefreshing) {
      _retryQueue.add(() async {
        try {
          final response = await _retryRequest(err.requestOptions);
          handler.resolve(response);
        } catch (e) {
          handler.next(err);
        }
      });
      return;
    }

    // 3. Start the refresh process
    _isRefreshing = true;

    try {
      await _refreshToken();

      // 4. Retry the original request that triggered the refresh
      try {
        final response = await _retryRequest(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        handler.next(err);
      }

      // 5. Retry all queued requests with the new token
      for (final retryCallback in _retryQueue) {
        await retryCallback();
      }
      _retryQueue.clear();
    } catch (e) {
      // 6. If refresh fails, clear the queue and propagate the error
      _retryQueue.clear();
      await tokenStorage.clearToken();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  bool _isRefreshRequest(RequestOptions options) {
    // Prevent refresh loops on auth endpoints
    return options.path.contains(ApiConstants.refresh) ||
        options.path.contains(ApiConstants.login) ||
        options.path.contains(ApiConstants.register) ||
        options.path.contains(ApiConstants.logout);
  }

  Future<void> _refreshToken() async {
    try {
      final response = await dio.post(ApiConstants.refresh);
      if (response.data != null &&
          (response.statusCode?.isBetween(200, 299) ?? false)) {
        final newToken = response.data['accessToken'] as String?;
        if (newToken != null) {
          await tokenStorage.saveAccessToken(newToken);
        }
      } else {
        throw Exception('Failed to refresh token: ${response.statusCode}');
      }
    } catch (e) {
      // If refresh fails, the token is invalid. Clear it to force re-login.
      await tokenStorage.clearToken();
      rethrow;
    }
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    // dio.fetch will re-run the request through all interceptors (including AuthInterceptor)
    // so the new token will be automatically attached to the headers.
    return dio.fetch(requestOptions);
  }
}
