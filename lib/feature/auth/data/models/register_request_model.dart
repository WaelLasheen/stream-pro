import 'package:stream_pro/core/services/device/device_info_service.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';

class RegisterRequestModel {
  final String email;
  final String password;
  final String name;
  final String? deviceToken;
  final String deviceType;
  final String? deviceName;
  final String? appVersion;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.deviceType,
    this.deviceToken,
    this.deviceName,
    this.appVersion,
  });

  factory RegisterRequestModel.fromParams({
    required RegisterParams params,
    required DeviceInfoData deviceInfo,
    String? deviceToken,
  }) {
    return RegisterRequestModel(
      email: params.email,
      password: params.password,
      name: params.name,
      deviceToken: deviceToken,
      deviceType: deviceInfo.deviceType,
      deviceName: deviceInfo.deviceName,
      appVersion: deviceInfo.appVersion,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'deviceType': deviceType,
    if (deviceToken != null) 'deviceToken': deviceToken,
    if (deviceName != null) 'deviceName': deviceName,
    if (appVersion != null) 'appVersion': appVersion,
  };
}
