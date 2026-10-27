import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/safe_call/safe_call.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() {
    return safeCall(() async {
      final model = await remoteDataSource.getProfile();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    String? name,
    String? avatarPath,
  }) {
    return safeCall(() async {
      final model = await remoteDataSource.updateProfile(
        name: name,
        avatarPath: avatarPath,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> deleteProfile() {
    return safeCall(() => remoteDataSource.deleteProfile());
  }
}
