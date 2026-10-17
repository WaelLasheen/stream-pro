import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;
  GetProfileUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return await _repository.getProfile();
  }
}
