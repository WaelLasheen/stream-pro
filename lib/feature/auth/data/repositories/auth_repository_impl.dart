import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/services/device/device_info_service.dart';
import 'package:stream_pro/core/services/google_auth/google_auth_service.dart';
import 'package:stream_pro/core/services/storage/token_storage_service.dart';
import 'package:stream_pro/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:stream_pro/feature/auth/data/models/google_login_request_model.dart';
import 'package:stream_pro/feature/auth/data/models/login_request_model.dart';
import 'package:stream_pro/feature/auth/data/models/register_request_model.dart';
import 'package:stream_pro/feature/auth/domain/entity/user_entity.dart';
import 'package:stream_pro/feature/auth/domain/repository/auth_repository.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NotificationService notificationService;
  final DeviceInfoService deviceInfoService;
  final GoogleAuthService googleAuthService;
  final TokenStorageService tokenStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.notificationService,
    required this.deviceInfoService,
    required this.googleAuthService,
    required this.tokenStorage,
  });

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    return safeCall(() async {
      final (fcmToken, deviceInfo) = await (
        notificationService.getToken(),
        deviceInfoService.getDeviceInfo(),
      ).wait;

      final request = LoginRequestModel.fromParams(
        params: params,
        deviceInfo: deviceInfo,
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
      final (fcmToken, deviceInfo) = await (
        notificationService.getToken(),
        deviceInfoService.getDeviceInfo(),
      ).wait;

      final request = RegisterRequestModel.fromParams(
        params: params,
        deviceInfo: deviceInfo,
        deviceToken: fcmToken,
      );
      final response = await remoteDataSource.register(request);
      await tokenStorage.saveAccessToken(response.accessToken);
      return response.user.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    return safeCall(() async {
      final (googleToken, fcmToken, deviceInfo) = await (
        googleAuthService.getIdToken(),
        notificationService.getToken(),
        deviceInfoService.getDeviceInfo(),
      ).wait;

      final request = GoogleLoginRequestModel.fromToken(
        token: googleToken,
        deviceInfo: deviceInfo,
        deviceToken: fcmToken,
      );
      final response = await remoteDataSource.loginWithGoogle(request);
      await tokenStorage.saveAccessToken(response.accessToken);
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

  @override
  Future<Either<Failure, void>> logout() {
    return safeCall(() => remoteDataSource.logout());
  }
}
