import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';

class RegisterRequestModel {
  final String email;
  final String password;
  final String name;
  final String? deviceToken;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
    this.deviceToken,
  });

  factory RegisterRequestModel.fromParams({
    required RegisterParams params,
    String? deviceToken,
  }) {
    return RegisterRequestModel(
      email: params.email,
      password: params.password,
      name: params.name,
      deviceToken: deviceToken,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    if (deviceToken != null) 'deviceToken': deviceToken,
  };
}
