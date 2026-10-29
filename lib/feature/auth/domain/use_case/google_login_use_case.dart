import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/auth/domain/entity/user_entity.dart';
import 'package:stream_pro/feature/auth/domain/repository/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository repository;

  GoogleLoginUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call() {
    return repository.loginWithGoogle();
  }
}
