import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';
import 'package:stream_pro/feature/auth/domain/repository/auth_repository.dart';
import 'package:stream_pro/feature/auth/domain/use_case/logout_use_case.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/domain/repositories/profile_repository.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/delete_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';

class _FakeProfileRepository implements ProfileRepository {
  Either<Failure, void> deleteResult = const Right(null);

  @override
  Future<Either<Failure, void>> deleteProfile() async => deleteResult;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeAuthRepository implements AuthRepository {
  Either<Failure, void> logoutResult = const Right(null);

  @override
  Future<Either<Failure, void>> logout() async => logoutResult;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeSessionCleanupService implements SessionCleanupService {
  int clearCount = 0;

  @override
  Future<void> clearSession() async {
    clearCount++;
  }
}

ProfileCubit _buildCubit({
  required _FakeProfileRepository profileRepository,
  required _FakeAuthRepository authRepository,
  required _FakeSessionCleanupService cleanupService,
}) {
  return ProfileCubit(
    getProfileUseCase: GetProfileUseCase(profileRepository),
    updateProfileUseCase: UpdateProfileUseCase(profileRepository),
    deleteProfileUseCase: DeleteProfileUseCase(profileRepository),
    logoutUseCase: LogoutUseCase(authRepository),
    sessionCleanupService: cleanupService,
  );
}

void main() {
  group('ProfileCubit account actions', () {
    late _FakeProfileRepository profileRepository;
    late _FakeAuthRepository authRepository;
    late _FakeSessionCleanupService cleanupService;

    setUp(() {
      profileRepository = _FakeProfileRepository();
      authRepository = _FakeAuthRepository();
      cleanupService = _FakeSessionCleanupService();
    });

    test(
      'deleting an account clears the session and emits ProfileDeleted',
      () async {
        final cubit = _buildCubit(
          profileRepository: profileRepository,
          authRepository: authRepository,
          cleanupService: cleanupService,
        );

        await cubit.deleteAccount();

        expect(cleanupService.clearCount, 1);
        expect(cubit.state, isA<ProfileDeleted>());

        await cubit.close();
      },
    );

    test(
      'a failed deletion keeps the session and emits ProfileError',
      () async {
        profileRepository.deleteResult = const Left(
          ServerFailure('Could not delete account'),
        );
        final cubit = _buildCubit(
          profileRepository: profileRepository,
          authRepository: authRepository,
          cleanupService: cleanupService,
        );

        await cubit.deleteAccount();

        expect(cleanupService.clearCount, 0);
        expect(cubit.state, isA<ProfileError>());
        expect(
          (cubit.state as ProfileError).message,
          'Could not delete account',
        );

        await cubit.close();
      },
    );

    test('logout clears the session even when the API call fails', () async {
      authRepository.logoutResult = const Left(ServerFailure('Network error'));
      final cubit = _buildCubit(
        profileRepository: profileRepository,
        authRepository: authRepository,
        cleanupService: cleanupService,
      );

      await cubit.logout();

      expect(cleanupService.clearCount, 1);
      expect(cubit.state, isA<ProfileLoggedOut>());

      await cubit.close();
    });
  });

  group('ProfileEntity', () {
    test('copyWith preserves avatar when only the name changes', () {
      final profile = ProfileEntity(
        id: '1',
        name: 'Old name',
        email: 'user@example.com',
        avatarUrl: 'https://example.com/avatar.png',
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
        videoCount: 3,
        totalViews: 42,
      );

      final updated = profile.copyWith(name: 'New name');

      expect(updated.name, 'New name');
      expect(updated.avatarUrl, profile.avatarUrl);
    });
  });
}
