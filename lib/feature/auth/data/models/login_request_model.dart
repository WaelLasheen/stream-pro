import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';

class LoginRequestModel {
  final String email;
  final String password;
  final String? deviceToken;

  LoginRequestModel({
    required this.email,
    required this.password,
    this.deviceToken,
  });

  factory LoginRequestModel.fromParams({
    required LoginParams params,
    String? deviceToken,
  }) {
    return LoginRequestModel(
      email: params.email,
      password: params.password,
      deviceToken: deviceToken,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    if (deviceToken != null) 'deviceToken': deviceToken,
  };
}
