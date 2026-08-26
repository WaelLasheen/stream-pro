import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/exceptions/server_exception.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';
import 'package:stream_pro/core/error/failures/unknown_failure.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() action) async {
  try {
    return Right(await action());
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}