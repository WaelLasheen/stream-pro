import 'package:stream_pro/feature/comments/presentation/params/user_params.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';

extension UserMapper on ProfileEntity {
  UserParams toUserParams() {
    return UserParams(
      userId: id,
      userName: name,
      userProfileImage: avatarUrl ?? '',
    );
  }
}
