import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({String? name, String? avatarPath});

  Future<void> deleteProfile();
}
