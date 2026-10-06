import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart'; // Adjust path if needed
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/services/storage/token_storage_service.dart';
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
    return safeCall(() async {
      final fcmToken = await notificationService.getToken();
      final request = LoginRequestModel.fromParams(
        params: params,
        deviceToken: fcmToken,
      );
      final response = await remoteDataSource.login(request);
      await tokenStorage.saveAccessToken(response.accessToken);
      return response.user.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> register(RegisterParams params) async {
    return safeCall(() async {
      final fcmToken = await notificationService.getToken();
      final request = RegisterRequestModel.fromParams(
        params: params,
        deviceToken: fcmToken,
      );
      final response = await remoteDataSource.register(request);
      return response.user.toEntity();
    });
  }

  @override
  Future<Either<Failure, String>> refreshToken() async {
    return safeCall(() async {
      final token = await remoteDataSource.refreshToken();
      await tokenStorage.saveAccessToken(token);
      return token;
    });
  }
}
