import 'package:dio/dio.dart';
import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/services/storage/token_storage_service.dart';

class RefreshInterceptor extends Interceptor {
  static const String _retriedAfterRefreshKey = 'retried_after_token_refresh';

  final Dio dio;
  final TokenStorageService tokenStorage;

  /// A single in-flight refresh shared by every request that receives a 401.
  Future<void>? _refreshFuture;

  RefreshInterceptor({required this.dio, required this.tokenStorage});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    // Do not refresh for non-401 errors, auth endpoints, or an already retried
    // request. The retry flag prevents an infinite refresh/retry loop.
    if (err.response?.statusCode != 401 ||
        _isAuthRequest(requestOptions) ||
        requestOptions.extra[_retriedAfterRefreshKey] == true) {
      handler.next(err);
      return;
    }

    // Every concurrent 401 waits for the same refresh operation. If refresh
    // fails, this request is completed with its original 401 instead of being
    // left pending in a queue.
    try {
      await _refreshAccessTokenOnce();
    } catch (_) {
      handler.next(err);
      return;
    }

    // Refresh succeeded. Retry this original request exactly once.
    try {
      final response = await _retryRequest(requestOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    } catch (error, stackTrace) {
      handler.next(
        DioException(
          requestOptions: requestOptions,
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  bool _isAuthRequest(RequestOptions options) {
    return options.path.contains(ApiConstants.refresh) ||
        options.path.contains(ApiConstants.login) ||
        options.path.contains(ApiConstants.register) ||
        options.path.contains(ApiConstants.logout);
  }

  Future<void> _refreshAccessTokenOnce() {
    final runningRefresh = _refreshFuture;
    if (runningRefresh != null) return runningRefresh;

    late final Future<void> refreshFuture;
    refreshFuture = _refreshToken().whenComplete(() {
      // Do not clear a newer refresh operation if one has already started.
      if (identical(_refreshFuture, refreshFuture)) {
        _refreshFuture = null;
      }
    });

    _refreshFuture = refreshFuture;
    return refreshFuture;
  }

  Future<void> _refreshToken() async {
    try {
      final response = await dio.post(ApiConstants.refresh);
      final responseData = response.data;

      if (responseData is! Map) {
        throw StateError('Refresh endpoint returned an invalid response.');
      }

      final newToken = responseData['accessToken'];
      if (newToken is! String || newToken.isEmpty) {
        throw StateError('Refresh endpoint did not return an access token.');
      }

      await tokenStorage.saveAccessToken(newToken);
    } catch (_) {
      // Best-effort local cleanup. Preserve the original refresh error.
      try {
        await tokenStorage.clearToken();
      } catch (_) {
        // The request handlers will still be completed with their original
        // 401 response, even if local token cleanup itself fails.
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) {
    final retryOptions = requestOptions.copyWith(
      extra: {...requestOptions.extra, _retriedAfterRefreshKey: true},
    );

    // Dio runs the request through interceptors again, so AuthInterceptor
    // attaches the newly saved access token.
    return dio.fetch<dynamic>(retryOptions);
  }
}
