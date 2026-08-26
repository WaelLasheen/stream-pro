import 'package:dio/dio.dart';
import 'package:stream_pro/core/error/exceptions/app_exception.dart';
import 'package:stream_pro/core/utils/extensions/number_range.dart';
import 'package:stream_pro/generated/l10n.dart';

class ServerException extends AppException {
  const ServerException(super.message);

  factory ServerException.fromDioException(DioException dioException) {
    final s = S.current;

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerException(s.connectionTimeout);

      case DioExceptionType.sendTimeout:
        return ServerException(s.sendTimeout);

      case DioExceptionType.receiveTimeout:
        return ServerException(s.receiveTimeout);

      case DioExceptionType.badCertificate:
        return ServerException(s.badCertificate);

      case DioExceptionType.badResponse:
        return ServerException.fromResponse(dioException.response);

      case DioExceptionType.cancel:
        return ServerException(s.requestCanceled);

      case DioExceptionType.connectionError:
        return ServerException(s.noInternetConnection);

      case DioExceptionType.unknown:
        return ServerException(s.unexpectedError);

      default:
        return ServerException(s.unexpectedError);
    }
  }

  factory ServerException.fromResponse(Response? response) {
    final s = S.current;

    final int? statusCode = response?.statusCode;
    final data = response?.data;

    if (statusCode != null && statusCode.isBetween(400, 499)) {
      return ServerException(data['message']);
    } else if (statusCode != null && statusCode.isBetween(500, 599)) {
      return ServerException(s.internalServerError);
    } else {
      return ServerException(s.oopsError);
    }
  }

  @override
  List<Object?> get props => [message];
}
