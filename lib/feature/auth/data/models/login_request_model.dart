import 'package:stream_pro/core/services/device/device_info_service.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';

class LoginRequestModel {
  final String email;
  final String password;
  final String? deviceToken;
  final String deviceType;
  final String? deviceName;
  final String? appVersion;

  LoginRequestModel({
    required this.email,
    required this.password,
    required this.deviceType,
    this.deviceToken,
    this.deviceName,
    this.appVersion,
  });

  factory LoginRequestModel.fromParams({
    required LoginParams params,
    required DeviceInfoData deviceInfo,
    String? deviceToken,
  }) {
    return LoginRequestModel(
      email: params.email,
      password: params.password,
      deviceToken: deviceToken,
      deviceType: deviceInfo.deviceType,
      deviceName: deviceInfo.deviceName,
      appVersion: deviceInfo.appVersion,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'deviceType': deviceType,
    if (deviceToken != null) 'deviceToken': deviceToken,
    if (deviceName != null) 'deviceName': deviceName,
    if (appVersion != null) 'appVersion': appVersion,
  };
}
