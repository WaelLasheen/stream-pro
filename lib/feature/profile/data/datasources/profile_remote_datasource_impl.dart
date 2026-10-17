import 'package:dio/dio.dart';
import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/profile_model.dart';
import 'profile_remote_datasource.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService _apiService;

  ProfileRemoteDataSourceImpl(this._apiService);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _apiService.get(ApiConstants.profileMe);
    final data = response.data['data'] as Map<String, dynamic>;
    return ProfileModel.fromJson(data);
  }

  @override
  Future<ProfileModel> updateProfile({String? name, String? avatarPath}) async {
    assert(
      name != null || avatarPath != null,
      'Provide at least name or avatarPath',
    );

    dynamic payload;
    if (avatarPath != null && avatarPath.isNotEmpty) {
      final fileName = avatarPath.split('/').last;
      payload = FormData.fromMap({
        if (name != null) 'name': name,
        'avatar': await MultipartFile.fromFile(
          avatarPath,
          filename: fileName,
        ),
      });
    } else {
      payload = {'name': name};
    }

    final response = await _apiService.patch(
      ApiConstants.profileMe,
      data: payload,
    );
    final envelope = response.data as Map<String, dynamic>?;
    final data = envelope?['data'];
    if (data is Map<String, dynamic>) {
      return ProfileModel.fromJson(data);
    }
    return getProfile();
  }

  @override
  Future<void> deleteProfile() async {
    await _apiService.delete(ApiConstants.profileMe);
  }
}
