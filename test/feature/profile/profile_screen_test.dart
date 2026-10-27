import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/core/services/file_picker/app_file_type.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/services/session/session_cleanup_service.dart';
import 'package:stream_pro/core/theme/app_themes.dart';
import 'package:stream_pro/feature/auth/domain/repository/auth_repository.dart';
import 'package:stream_pro/feature/auth/domain/use_case/logout_use_case.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/domain/repositories/profile_repository.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/delete_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:stream_pro/feature/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/screens/profile_screen.dart';
import 'package:stream_pro/generated/l10n.dart';

class _FakeProfileRepository implements ProfileRepository {
  final ProfileEntity profile;

  _FakeProfileRepository(this.profile);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async => Right(profile);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeAuthRepository implements AuthRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeSessionCleanupService implements SessionCleanupService {
  @override
  Future<void> clearSession() async {}
}

class _FakeFilePickerService implements FilePickerService {
  @override
  Future<String?> pickFile({
    required AppFileType type,
    bool allowMultiple = false,
    List<String>? allowedExtensions,
  }) async => null;

  @override
  Future<List<String>?> pickFiles({
    required AppFileType type,
    bool allowMultiple = true,
    List<String>? allowedExtensions,
  }) async => null;
}

void main() {
  testWidgets('renders the profile details and stats', (tester) async {
    final repository = _FakeProfileRepository(
      ProfileEntity(
        id: '1',
        name: 'Jane Doe',
        email: 'jane@example.com',
        avatarUrl: null,
        createdAt: DateTime(2026, 1, 15),
        updatedAt: DateTime(2026, 1, 15),
        videoCount: 1200,
        totalViews: 25000,
      ),
    );
    final cubit = ProfileCubit(
      getProfileUseCase: GetProfileUseCase(repository),
      updateProfileUseCase: UpdateProfileUseCase(repository),
      deleteProfileUseCase: DeleteProfileUseCase(repository),
      logoutUseCase: LogoutUseCase(_FakeAuthRepository()),
      sessionCleanupService: _FakeSessionCleanupService(),
    );
    await cubit.fetchProfile();

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, _) => MaterialApp(
          theme: AppThemes().lightTheme,
          locale: const Locale('en'),
          localizationsDelegates: const [S.delegate],
          supportedLocales: S.delegate.supportedLocales,
          home: BlocProvider.value(
            value: cubit,
            child: ProfileScreen(filePickerService: _FakeFilePickerService()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('jane@example.com'), findsOneWidget);
    expect(find.text('1.2K'), findsOneWidget);
    expect(find.text('25.0K'), findsOneWidget);
    expect(find.text(S.current.videosLabel), findsOneWidget);
    expect(find.text(S.current.totalViewsLabel), findsOneWidget);

    await cubit.close();
  });
}
