import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/exceptions/server_exception.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';
import 'package:stream_pro/core/error/failures/unknown_failure.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/storage/token_storage_service.dart';
import 'package:stream_pro/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:stream_pro/feature/auth/data/models/login_request_model.dart';
import 'package:stream_pro/feature/auth/data/models/register_request_model.dart';
import 'package:stream_pro/feature/auth/domain/entity/user_entity.dart';
import 'package:stream_pro/feature/auth/domain/repository/auth_repository.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NotificationService notificationService;
  final TokenStorageService tokenStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.notificationService,
    required this.tokenStorage,
  });

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    try {
      final fcmToken = await notificationService.getToken();

      final request = LoginRequestModel.fromParams(
        params: params,
        deviceToken: fcmToken,
      );

      final response = await remoteDataSource.login(request);
      await tokenStorage.saveAccessToken(response.accessToken);
      final user = response.user.toEntity();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(RegisterParams params) async {
    try {
      final fcmToken = await notificationService.getToken();

      final request = RegisterRequestModel.fromParams(
        params: params,
        deviceToken: fcmToken,
      );

      final response = await remoteDataSource.register(request);
      final user = response.user.toEntity();

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
