import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/profile/domain/repositories/profile_repository.dart';

class DeleteProfileUseCase {
  final ProfileRepository _repository;
  DeleteProfileUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.deleteProfile();
  }
}
