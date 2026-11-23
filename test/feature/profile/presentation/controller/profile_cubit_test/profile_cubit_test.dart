import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';
import 'package:stream_pro/feature/auth/domain/use_case/logout_use_case.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/delete_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class MockDeleteProfileUseCase extends Mock implements DeleteProfileUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockSessionCleanupService extends Mock implements SessionCleanupService {}

void main() {
  late MockGetProfileUseCase mockGetProfileUseCase;
  late MockUpdateProfileUseCase mockUpdateProfileUseCase;
  late MockDeleteProfileUseCase mockDeleteProfileUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockSessionCleanupService mockSessionCleanupService;

  late ProfileCubit cubit;

  // Test data
  final profile = ProfileEntity(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
    avatarUrl: 'https://example.com/avatar.png',
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2025, 2, 1),
    videoCount: 10,
    totalViews: 500,
  );

  const serverFailure = ServerFailure('Server error', statusCode: 500);

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    mockUpdateProfileUseCase = MockUpdateProfileUseCase();
    mockDeleteProfileUseCase = MockDeleteProfileUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockSessionCleanupService = MockSessionCleanupService();

    cubit = ProfileCubit(
      getProfileUseCase: mockGetProfileUseCase,
      updateProfileUseCase: mockUpdateProfileUseCase,
      deleteProfileUseCase: mockDeleteProfileUseCase,
      logoutUseCase: mockLogoutUseCase,
      sessionCleanupService: mockSessionCleanupService,
    );
  });

  // =========================================================
  // Fetch Profile
  // =========================================================

  group('fetchProfile', () {
    blocTest<ProfileCubit, ProfileState>(
      'should emit [ProfileLoading, ProfileLoaded] when fetching succeeds',
      build: () {
        when(
          () => mockGetProfileUseCase(),
        ).thenAnswer((_) async => Right(profile));

        return cubit;
      },
      act: (cubit) => cubit.fetchProfile(),
      expect: () => [const ProfileLoading(), ProfileLoaded(profile: profile)],
      verify: (_) {
        verify(() => mockGetProfileUseCase()).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should emit [ProfileLoading, ProfileError] when fetching fails',
      build: () {
        when(
          () => mockGetProfileUseCase(),
        ).thenAnswer((_) async => const Left(serverFailure));

        return cubit;
      },
      act: (cubit) => cubit.fetchProfile(),
      expect: () => [
        const ProfileLoading(),
        ProfileError(message: serverFailure.message),
      ],
      verify: (_) {
        verify(() => mockGetProfileUseCase()).called(1);
      },
    );
  });

  // =========================================================
  // Delete Account
  // =========================================================

  group('deleteAccount', () {
    blocTest<ProfileCubit, ProfileState>(
      'should emit [ProfileLoaded(isDeleting), ProfileDeleted] when deletion succeeds',
      build: () {
        when(
          () => mockDeleteProfileUseCase(),
        ).thenAnswer((_) async => Right(null));

        when(
          () => mockSessionCleanupService.clearSession(),
        ).thenAnswer((_) async {});

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) => cubit.deleteAccount(),
      expect: () => [
        ProfileLoaded(profile: profile, isDeleting: true),
        const ProfileDeleted(),
      ],
      verify: (_) {
        verify(() => mockDeleteProfileUseCase()).called(1);
        verify(() => mockSessionCleanupService.clearSession()).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should emit [ProfileLoaded(isDeleting), ProfileError] when deletion fails',
      build: () {
        when(
          () => mockDeleteProfileUseCase(),
        ).thenAnswer((_) async => const Left(serverFailure));

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) => cubit.deleteAccount(),
      expect: () => [
        ProfileLoaded(profile: profile, isDeleting: true),
        ProfileError(message: serverFailure.message, profile: profile),
      ],
      verify: (_) {
        verify(() => mockDeleteProfileUseCase()).called(1);
        verifyNever(() => mockSessionCleanupService.clearSession());
      },
    );
  });

  // =========================================================
  // Update Profile
  // =========================================================

  group('updateProfile', () {
    const updatedName = 'Updated Name';
    const avatarPath = '/tmp/new-avatar.png';
    const updatedAvatarUrl = 'https://example.com/new-avatar.png';

    blocTest<ProfileCubit, ProfileState>(
      'should not update profile when there are no actual changes',
      build: () => cubit,
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) async {
        await cubit.updateProfile();
        await cubit.updateProfile(name: '');
        await cubit.updateProfile(name: '   ');
        await cubit.updateProfile(name: profile.name);
      },
      expect: () => [],
      verify: (_) {
        verifyNever(
          () => mockUpdateProfileUseCase(
            name: any(named: 'name'),
            avatarPath: any(named: 'avatarPath'),
          ),
        );
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should emit optimistic and updated profile when name changes',
      build: () {
        final returnedProfile = profile.copyWith(name: updatedName);

        when(
          () => mockUpdateProfileUseCase(name: updatedName, avatarPath: null),
        ).thenAnswer((_) async => Right(returnedProfile));

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) => cubit.updateProfile(name: '  Updated Name  '),
      expect: () => [
        ProfileLoaded(
          profile: profile.copyWith(name: updatedName),
          isSaving: true,
        ),
        ProfileLoaded(profile: profile.copyWith(name: updatedName)),
      ],
      verify: (_) {
        verify(
          () => mockUpdateProfileUseCase(name: updatedName, avatarPath: null),
        ).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should emit optimistic and updated profile when avatar changes',
      build: () {
        final returnedProfile = profile.copyWith(avatarUrl: updatedAvatarUrl);

        when(
          () => mockUpdateProfileUseCase(avatarPath: avatarPath),
        ).thenAnswer((_) async => Right(returnedProfile));

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) => cubit.updateProfile(avatarPath: avatarPath),
      expect: () => [
        ProfileLoaded(profile: profile, isSaving: true),
        ProfileLoaded(profile: profile.copyWith(avatarUrl: updatedAvatarUrl)),
      ],
      verify: (_) {
        verify(
          () => mockUpdateProfileUseCase(name: null, avatarPath: avatarPath),
        ).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should emit optimistic and updated profile when name and avatar change',
      build: () {
        final returnedProfile = profile.copyWith(
          name: updatedName,
          avatarUrl: updatedAvatarUrl,
        );

        when(
          () => mockUpdateProfileUseCase(
            name: updatedName,
            avatarPath: avatarPath,
          ),
        ).thenAnswer((_) async => Right(returnedProfile));

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) =>
          cubit.updateProfile(name: updatedName, avatarPath: avatarPath),
      expect: () => [
        ProfileLoaded(
          profile: profile.copyWith(name: updatedName),
          isSaving: true,
        ),
        ProfileLoaded(
          profile: profile.copyWith(
            name: updatedName,
            avatarUrl: updatedAvatarUrl,
          ),
        ),
      ],
      verify: (_) {
        verify(
          () => mockUpdateProfileUseCase(
            name: updatedName,
            avatarPath: avatarPath,
          ),
        ).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should restore the original profile when update fails',
      build: () {
        when(
          () => mockUpdateProfileUseCase(
            name: updatedName,
            avatarPath: avatarPath,
          ),
        ).thenAnswer((_) async => const Left(serverFailure));

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) =>
          cubit.updateProfile(name: updatedName, avatarPath: avatarPath),
      expect: () => [
        ProfileLoaded(
          profile: profile.copyWith(name: updatedName),
          isSaving: true,
        ),
        ProfileError(message: serverFailure.message, profile: profile),
      ],
      verify: (_) {
        verify(
          () => mockUpdateProfileUseCase(
            name: updatedName,
            avatarPath: avatarPath,
          ),
        ).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should not start another update while saving',
      build: () => cubit,
      seed: () => ProfileLoaded(profile: profile, isSaving: true),
      act: (cubit) =>
          cubit.updateProfile(name: updatedName, avatarPath: avatarPath),
      expect: () => [],
      verify: (_) {
        verifyNever(
          () => mockUpdateProfileUseCase(
            name: any(named: 'name'),
            avatarPath: any(named: 'avatarPath'),
          ),
        );
      },
    );
  });

  // =========================================================
  // Logout
  // =========================================================

  group('logout', () {
    blocTest<ProfileCubit, ProfileState>(
      'should emit [ProfileLoaded(isLoggingOut), ProfileLoggedOut] when logout succeeds',
      build: () {
        when(() => mockLogoutUseCase()).thenAnswer((_) async => Right(null));

        when(
          () => mockSessionCleanupService.clearSession(),
        ).thenAnswer((_) async {});

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) => cubit.logout(),
      expect: () => [
        ProfileLoaded(profile: profile, isLoggingOut: true),
        const ProfileLoggedOut(),
      ],
      verify: (_) {
        verify(() => mockLogoutUseCase()).called(1);
        verify(() => mockSessionCleanupService.clearSession()).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'should emit [ProfileLoaded(isLoggingOut), ProfileError] when logout fails',
      build: () {
        when(
          () => mockLogoutUseCase(),
        ).thenAnswer((_) async => const Left(serverFailure));

        return cubit;
      },
      seed: () => ProfileLoaded(profile: profile),
      act: (cubit) => cubit.logout(),
      expect: () => [
        ProfileLoaded(profile: profile, isLoggingOut: true),
        ProfileError(message: serverFailure.message, profile: profile),
      ],
      verify: (_) {
        verify(() => mockLogoutUseCase()).called(1);
        verifyNever(() => mockSessionCleanupService.clearSession());
      },
    );
  });
}
