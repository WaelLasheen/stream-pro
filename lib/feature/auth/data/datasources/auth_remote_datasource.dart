import 'package:stream_pro/feature/auth/data/models/auth_data_model.dart';
import 'package:stream_pro/feature/auth/data/models/login_request_model.dart';
import 'package:stream_pro/feature/auth/data/models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthDataModel> login(LoginRequestModel request);
  Future<AuthDataModel> register(RegisterRequestModel request);
}
