import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;
  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call({
    String? name,
    String? avatarPath,
  }) async {
    assert(name != null || avatarPath != null, 'Nothing to update');
    return await _repository.updateProfile(
      name: name,
      avatarPath: avatarPath,
    );
  }
}
