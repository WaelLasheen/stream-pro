import 'package:stream_pro/core/services/device/device_info_service.dart';

class GoogleLoginRequestModel {
  final String token;
  final String? deviceToken;
  final String deviceType;
  final String? deviceName;
  final String? appVersion;

  GoogleLoginRequestModel({
    required this.token,
    required this.deviceType,
    this.deviceToken,
    this.deviceName,
    this.appVersion,
  });

  factory GoogleLoginRequestModel.fromToken({
    required String token,
    required DeviceInfoData deviceInfo,
    String? deviceToken,
  }) {
    return GoogleLoginRequestModel(
      token: token,
      deviceToken: deviceToken,
      deviceType: deviceInfo.deviceType,
      deviceName: deviceInfo.deviceName,
      appVersion: deviceInfo.appVersion,
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'deviceType': deviceType,
    if (deviceToken != null) 'deviceToken': deviceToken,
    if (deviceName != null) 'deviceName': deviceName,
    if (appVersion != null) 'appVersion': appVersion,
  };
}
