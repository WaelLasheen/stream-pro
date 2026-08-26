import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/auth/data/models/auth_data_model.dart';
import 'package:stream_pro/feature/auth/data/models/login_request_model.dart';
import 'package:stream_pro/feature/auth/data/models/register_request_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<AuthDataModel> login(LoginRequestModel request) async {
    final response = await apiService.post(
      ApiConstants.login,
      data: request.toJson(),
    );
    return AuthDataModel.fromJson(response.data['data']);
  }

  @override
  Future<AuthDataModel> register(RegisterRequestModel request) async {
    final response = await apiService.post(
      ApiConstants.register,
      data: request.toJson(),
    );
    return AuthDataModel.fromJson(response.data['data']);
  }
}
