import 'package:stream_pro/feature/auth/data/models/user_model.dart';

class AuthDataModel {
  final String accessToken;
  final UserModel user;

  AuthDataModel({required this.accessToken, required this.user});

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      accessToken: json['accessToken'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
